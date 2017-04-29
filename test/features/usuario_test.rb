require './test/test_helper'

feature 'Usuario' do
  feature 'anónimamente' do

    scenario 'visita la bienvenida' do
      visit root_path

      page.must_have_content 'Bienvenido mortal'
      page.must_have_link nil, href: legales_path
      page.must_have_link nil, href: Rails.configuration.sitio_oficial
      page.must_have_link nil, href: new_usuario_registration_path
      page.must_have_link nil, href: new_usuario_session_path
      page.must_have_field "q_#{busqueda}"
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

      page.must_have_link nil, href: usuario_path(usuario)
      page.must_have_link nil, href: destroy_usuario_session_path
    end
  end

  feature 'logueado' do
    background { @usuario = loguearse }
    after { logout }

    scenario 'visita la bienvenida' do
      visit root_path

      page.must_have_link nil, href: legales_path
      page.must_have_link nil, href: Rails.configuration.sitio_oficial
      page.must_have_link nil, href: usuario_path(@usuario)
      page.must_have_link nil, href: destroy_usuario_session_path
      page.must_have_field "q_#{busqueda}"
    end

    scenario 'visita su panel' do
      visit usuario_path(@usuario)

      current_path.must_equal usuario_path(@usuario)
      page.must_have_link nil, href: usuario_coleccion_path(@usuario)
      page.must_have_link nil, href: usuario_reserva_path(usuario)
      page.must_have_link nil, href: faltantes_usuario_coleccion_path(@usuario)
      page.must_have_link nil, href: sobrantes_usuario_coleccion_path(@usuario)
    end

  end
end
