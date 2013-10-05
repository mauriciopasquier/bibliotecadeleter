# encoding: utf-8
require "./test/test_helper"

feature "Usuario" do
  feature "anónimamente" do

    scenario "visita la bienvenida" do
      visit root_path

      page.must_have_content "Bienvenido mortal"
      page.must_have_link nil, href: legales_path
      page.must_have_link nil, href: 'http://playinferno.com'
      page.must_have_link nil, href: new_usuario_registration_path
      page.must_have_link nil, href: new_usuario_session_path
      page.must_have_field "q_#{busqueda}"
    end

    scenario "no puede entrar al panel" do
      visit panel_path
      current_path.must_equal root_path
    end

    scenario 'se loguea' do
      usuario = create(:usuario)

      visit new_usuario_session_path
      current_path.must_equal new_usuario_session_path

      usuario.reload
      within '#usuarios form' do
        fill_in Usuario.human_attribute_name('email'),    with: usuario.email
        fill_in Usuario.human_attribute_name('password'), with: usuario.password
        click_button I18n.t('devise.sessions.new.submit')
      end

      page.must_have_link nil, href: panel_path
      page.must_have_link nil, href: destroy_usuario_session_path
    end
  end

  feature "logueado" do
    background { @usuario = loguearse }
    after { logout }

    scenario "visita la bienvenida" do
      visit root_path

      page.must_have_link nil, href: legales_path
      page.must_have_link nil, href: 'http://playinferno.com'
      page.must_have_link nil, href: panel_path
      page.must_have_link nil, href: destroy_usuario_session_path
      page.must_have_field "q_#{busqueda}"
    end

    scenario "visita su panel" do
      visit panel_path

      current_path.must_equal panel_path
      page.must_have_link nil, href: coleccion_path
      page.must_have_link nil, href: reserva_path
      page.must_have_link nil, href: faltantes_coleccion_path
      page.must_have_link nil, href: sobrantes_coleccion_path
    end

  end
end
