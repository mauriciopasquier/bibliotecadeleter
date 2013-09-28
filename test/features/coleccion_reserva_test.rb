# encoding: utf-8
require "./test/test_helper"

feature 'Colección/Reserva' do
  feature 'anónimamente' do
    scenario "no ve los links" do
      version = create(:version_con_carta)
      visit expansion_path(version.expansion)
      current_path.must_equal expansion_path(version.expansion)
      page.must_have_link nil,
        en_expansion_carta_path(version.carta, expansion: version.expansion)
      page.wont_have_content 'Quiero'
      page.wont_have_content 'Tengo'
      page.wont_have_link nil,
        href: reserva_path(cantidad: 1, version_id: version.id)
      page.wont_have_link nil,
        href: coleccion_path(cantidad: 1, version_id: version.id)
    end
  end

  feature 'logueado' do
    background { @usuario = loguearse }

    scenario "actualiza con ajax", js: true do
      version = create(:version_con_carta)
      visit en_expansion_carta_path(version.carta, expansion: version.expansion)
      current_path.must_equal en_expansion_carta_path(version.carta, expansion: version.expansion)

      within '#falsos.controles' do
        within '.control-reserva' do
          page.must_have_selector '.control-texto', text: 'Quiero'
        end
        within '.control-coleccion' do
          page.must_have_selector '.control-texto', text: 'Tengo'
        end
      end

      within "##{version.expansion.slug}.controles" do
        within '.control-reserva' do
          page.must_have_selector '.cantidad', text: 0
          @usuario.reserva.cantidad.must_equal 0
          page.must_have_selector 'a.update-listas.agregar i', count: 1
          page.must_have_selector 'a.update-listas.remover i', count: 1

          find('a.agregar').click
          sleep 3
          @usuario.reserva.cantidad.must_equal 1
          page.must_have_selector '.cantidad', text: 1
          find('a.remover').click
          sleep 2
          @usuario.reserva.cantidad.must_equal 0
          page.must_have_selector '.cantidad', text: 0
        end

        within '.control-coleccion' do
          page.must_have_selector '.cantidad', text: 0
          @usuario.coleccion.cantidad.must_equal 0
          page.must_have_selector 'a.update-listas.agregar i', count: 1
          page.must_have_selector 'a.update-listas.remover i', count: 1

          find('a.agregar').click
          sleep 3
          @usuario.coleccion.cantidad.must_equal 1
          page.must_have_selector '.cantidad', text: 1
          find('a.remover').click
          sleep 2
          @usuario.coleccion.cantidad.must_equal 0
          page.must_have_selector '.cantidad', text: 0
        end
      end
    end
  end
end
