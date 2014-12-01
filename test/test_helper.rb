# encoding: utf-8
ENV['RAILS_ENV'] = 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'minitest/rails'
require 'minitest/rails/capybara'

DatabaseCleaner.clean_with :truncation
DatabaseCleaner.strategy = :transaction

class MiniTest::Unit::TestCase
  # Para llamar a los métodos core de FactoryGirl directamente (build,
  # build_stubbed, create, attributes_for, y los *_list)
  include FactoryGirl::Syntax::Methods
end

class MiniTest::Spec
  before { DatabaseCleaner.start }
  after { DatabaseCleaner.clean }
end

class ActionController::TestCase
  include Devise::TestHelpers

  before { DatabaseCleaner.start }
  after { DatabaseCleaner.clean }

  def loguearse
    @request.env['devise.mapping'] = Devise.mappings[:usuario]
    sign_in usuario = create(:usuario)
    return usuario
  end

  # Autorizar cualquier cosa que se haga en el bloque
  def autorizar
    @ability = Object.new
    @ability.extend(CanCan::Ability)
    @ability.can :manage, :all
    @controller.stub(:current_ability, @ability) do
      yield
    end
  end

  def json
    ActiveSupport::JSON.decode @response.body
  end
end

# Capybara is intended to be used for automating a browser to test your
# application’s features. This is different than the integration tests that
# Rails provides, so you must use the Capybara::Rails::TestCase for your
# feature tests.
class Capybara::Rails::TestCase
  include ApplicationHelper
  include Warden::Test::Helpers # login_as

  # Transactional fixtures do not work with Selenium tests, because Capybara
  # uses a separate server thread, which the transactions would be hidden
  # from. We hence use DatabaseCleaner to truncate our test database.
  DatabaseCleaner.strategy = :truncation
  # Stop ActiveRecord from wrapping tests in transactions
  self.use_transactional_fixtures = false

  after do
    DatabaseCleaner.clean       # Truncate the database
    Capybara.reset_sessions!    # Forget the (simulated) browser state
    Capybara.use_default_driver # Revert Capybara.current_driver to Capybara.default_driver
    # Limpiar los hooks de warden para todos los request (ver +loguearse_como+)
    Warden::Manager._on_request.clear
    Warden.test_reset!
  end

  def loguearse_como(usuario)
    # Este debería ser el default de Warden
    Warden::Manager.on_request do |proxy|
      proxy.set_user usuario, scope: :usuario
    end

    usuario
  end

  def loguearse
    loguearse_como(create(:usuario))
  end
end

# Infectamos las assertions con el estilo de Expectations de minitest spec
module BibliotecaDelEter::Expectations
  infect_an_assertion :assert_redirected_to, :must_redirect_to
  infect_an_assertion :assert_template, :must_render_template
  infect_an_assertion :assert_response, :must_respond_with
  infect_an_assertion :assert_difference, :must_change
  infect_an_assertion :assert_no_difference, :wont_change
  infect_an_assertion :assert_select, :must_select
end

# Incluimos estas Expectations en Object para poder usarlas sobre cualquier
# cosa
class Object
  include BibliotecaDelEter::Expectations
end

# Registrando el driver podemos pasar opciones como el profile a usar
Capybara.register_driver :selenium do |app|
  Capybara::Selenium::Driver.new app, browser: :firefox, profile: 'selenium'
end

class Draper::TestCase
  include ActionView::TestCase::Behavior
  before { setup_with_controller }
end
