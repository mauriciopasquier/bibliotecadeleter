# encoding: utf-8
require "./test/test_helper"

feature "Usuario" do
  feature "Sin login" do

    scenario "Visita la bienvenida" do
      visit root_path

      page.must_have_content "Bienvenido mortal"
      page.must_have_link nil, href: legales_path
      page.must_have_link nil, href: 'http://playinferno.com'
      page.must_have_link nil, href: new_usuario_registration_path
      page.must_have_link nil, href: new_usuario_session_path
      page.must_have_field "q_#{busqueda}"
    end

    scenario "No puede entrar al panel" do
      visit panel_path
      current_path.must_equal root_path
    end
  end

  feature "Logueado" do
    background { @usuario = loguearse }

    scenario "Visita la bienvenida" do
      visit root_path

      page.must_have_link nil, href: legales_path
      page.must_have_link nil, href: 'http://playinferno.com'
      page.must_have_link nil, href: panel_path
      page.must_have_link nil, href: destroy_usuario_session_path
      page.must_have_field "q_#{busqueda}"
    end

    scenario "Visita su panel" do
      visit panel_path

      current_path.must_equal panel_path
      page.must_have_link nil, href: coleccion_path
      page.must_have_link nil, href: reserva_path
      page.must_have_link nil, href: faltantes_coleccion_path
      page.must_have_link nil, href: sobrantes_coleccion_path
    end
  end
end
