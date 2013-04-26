# encoding: utf-8
ENV["RAILS_ENV"] = "test"
require File.expand_path("../../config/environment", __FILE__)
require "rails/test_help"
require "minitest/rails"

# To add Capybara feature tests add `gem "minitest-rails-capybara"`
# to the test group in the Gemfile and uncomment the following:
require "minitest/rails/capybara"

class ActiveSupport::TestCase
  # Para llamar a los métodos core de FactoryGirl directamente (build,
  # build_stubbed, create, attributes_for, y los *_list)
  include FactoryGirl::Syntax::Methods
end

class ActionController::TestCase
  include Devise::TestHelpers

  def loguearse
    usuario = create :usuario
    @request.env["devise.mapping"] = Devise.mappings[:usuario]
    sign_in usuario
    return usuario
  end

  def json
    ActiveSupport::JSON.decode @response.body
  end
end
