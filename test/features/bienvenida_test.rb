# encoding: utf-8
require "./test/test_helper"

# To be handled correctly by Capybara this spec must end with "Feature Test"
feature "Bienvenida Feature Test" do
  scenario "Sin login" do
    visit root_path

    page.must_have_content "Bienvenido mortal"
    page.must_have_link nil, href: legales_path
    page.must_have_link nil, href: 'http://playinferno.com'
    page.must_have_link nil, href: new_usuario_registration_path
    page.must_have_link nil, href: new_usuario_session_path
    page.must_have_field "q_#{busqueda}"
  end

  scenario "Logueado" do
    usuario = loguearse
    visit root_path

    page.must_have_link nil, href: legales_path
    page.must_have_link nil, href: 'http://playinferno.com'
    page.must_have_link nil, href: panel_path
    page.must_have_link nil, href: destroy_usuario_session_path
    page.must_have_field "q_#{busqueda}"
  end
end
