# encoding: utf-8
require "./test/test_helper"

feature 'Colección/Reserva' do
  feature 'anónimamente' do
    scenario "no hay rastros de colección/reserva" do
      version = create(:version_con_carta)
      visit expansion_path(version.expansion)
      current_path.must_equal expansion_path(version.expansion)
      page.must_have_link nil,
        en_expansion_carta_path(version.carta, expansion: version.expansion)
      page.wont_have_content 'Quiero'
      page.wont_have_content 'Tengo'
    end
  end

  feature 'logueado' do
    background do
      @usuario = loguearse
      @version = create(:version_con_carta)

      visit en_expansion_carta_path(@version.carta, expansion: @version.expansion)
    end

    after { logout }

    scenario "ve la estructura de colección/reserva" do
      within '#falsos.controles' do
        within '.control-reserva' do
          page.must_have_selector '.control-texto', text: 'Quiero'
        end
        within '.control-coleccion' do
          page.must_have_selector '.control-texto', text: 'Tengo'
        end
      end

      within "##{@version.expansion.slug}.controles" do
        within '.control-reserva' do
          page.must_have_selector '.cantidad', text: 0
          page.must_have_selector 'a.update-listas.agregar i', count: 1
          page.must_have_selector 'a.update-listas.remover i', count: 1
        end

        within '.control-coleccion' do
          page.must_have_selector '.cantidad', text: 0
          page.must_have_selector 'a.update-listas.agregar i', count: 1
          page.must_have_selector 'a.update-listas.remover i', count: 1
        end
      end
    end

    scenario "actualiza la reserva con ajax", js: true do
      within "##{@version.expansion.slug}.controles" do
        within('.control-reserva') do
          page.must_have_selector '.cantidad', text: 0
          click_link 'Agregar a'
          page.must_have_selector '.cantidad', text: 1
          click_link 'Remover de'
          page.must_have_selector '.cantidad', text: 0
        end
      end
    end

    scenario "actualiza la colección con ajax", js: true do
      within "##{@version.expansion.slug}.controles" do
        within '.control-coleccion' do
          page.must_have_selector '.cantidad', text: 0
          click_link 'Agregar a'
          page.must_have_selector '.cantidad', text: 1
          click_link 'Remover de'
          page.must_have_selector '.cantidad', text: 0
        end
      end
    end
  end
end
