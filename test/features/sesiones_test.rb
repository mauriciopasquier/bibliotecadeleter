# encoding: utf-8
require "./test/test_helper"

# To be handled correctly by Capybara this spec must end with "Feature Test"
feature "Sesiones Feature Test" do
  scenario "Bienvenida sin login" do
    visit root_path
    page.must_have_content "Bienvenido mortal"
  end

  scenario "Bienvenida estando logueado" do
    usuario = loguearse
    visit root_path
    # TODO testear algo
  end
end
