# encoding: utf-8
ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)

require "minitest/autorun"
require "minitest/rails"

# Uncomment if you want Capybara in accceptance/integration tests
require "minitest/rails/capybara"

# Uncomment if you want awesome colorful output
require "minitest/pride"

class MiniTest::Rails::ActiveSupport::TestCase
  # Para llamar a los métodos core de FactoryGirl directamente (build,
  # build_stubbed, create, attributes_for, y los *_list)
  include FactoryGirl::Syntax::Methods
end

class MiniTest::Rails::ActionController::TestCase
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

# Do you want all existing Rails tests to use MiniTest::Rails?
# Comment out the following and either:
# A) Change the require on the existing tests to `require "minitest_helper"`
# B) Require this file's code in test_helper.rb

MiniTest::Rails.override_testunit!
