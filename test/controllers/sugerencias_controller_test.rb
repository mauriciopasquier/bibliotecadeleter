# encoding: utf-8
require "./test/test_helper"

describe SugerenciasController do
  describe 'cartas' do
    describe 'rutas' do
      it 'rutea al default' do
        assert_routing(
          { method: :get, path: '/sugerencias/cartas' },
          { controller: 'sugerencias', action: 'cartas' }
        )
      end

      it 'rutea con filtro' do
        assert_routing(
          { method: :get, path: '/sugerencias/cartas/demonios' },
          { controller: 'sugerencias', action: 'cartas', filtro: 'demonios' }
        )
      end

      it 'rutea con queries' do
        assert_routing('sugerencias/cartas/canonicas',
          { controller: 'sugerencias', action: 'cartas', filtro: 'canonicas',
            term: 'bag' },
          { },
          { term: 'bag' }
        )
      end
    end

    describe 'json' do
      before do
        @carta = create(:carta, nombre: 'sarasa',
          versiones_attributes: {
            '0' => attributes_for(:version,
              expansion_id: create(:expansion).id, canonica: true),
            '1' => attributes_for(:version,
              expansion_id: create(:expansion).id)
          }
        )
      end

      it 'sugiere cada versión' do
        get :cartas, term: 'sa'

        must_respond_with :success
        json.size.must_equal 2

        json.each do |resultado|
          valores = resultado.last.with_indifferent_access
          version = @carta.versiones.find(resultado.first)

          valores[:value].must_equal version.nombre_y_expansion
          valores[:label].must_equal version.nombre_y_expansion
          valores[:id].must_equal version.id.to_s
        end
      end

      it 'sugiere versiones canónicas' do
        get :cartas, filtro: :canonicas, term: 'sa'

        must_respond_with :success
        json.size.must_equal 1

        valores = json.first.last.with_indifferent_access

        valores[:value].must_equal @carta.nombre_y_expansiones
        valores[:label].must_equal @carta.nombre_y_expansiones
        valores[:id].must_equal @carta.canonica.id.to_s
      end

      it 'sugiere sólo demonios' do
        version = create(:version_con_carta, supertipo: 'Demonio')
        get :cartas, filtro: :canonicas, term: version.nombre

        must_respond_with :success
        json.size.must_equal 1

        valores = json.first.last.with_indifferent_access

        valores[:value].must_equal version.nombre_y_expansion
        valores[:label].must_equal version.nombre_y_expansion
        valores[:id].must_equal version.id.to_s
      end

      it 'sugiere por sendas' do
        get :cartas, filtro: :canonicas, term: 'sa',
          sendas: 'caos'

        must_respond_with :success
        json.size.must_equal 0
      end

      it 'combina sendas' do
        create(:version, senda: 'Caos',
          carta_id: create(:carta, nombre: 'sacala').id)
        version = create(:version, senda: 'Neutral',
          carta_id: create(:carta, nombre: 'sanata').id)

        get :cartas, filtro: :canonicas, term: 'sa',
          sendas: ['neutral', 'locura']

        must_respond_with :success
        json.size.must_equal 2

        get :cartas, term: 'sa',
          sendas: ['neutral', 'locura']

        must_respond_with :success
        json.size.must_equal 3
      end
    end
  end

  describe 'expansiones' do
    describe 'rutas' do
      it 'rutea al default' do
        assert_routing(
          { method: :get, path: '/sugerencias/expansiones' },
          { controller: 'sugerencias', action: 'expansiones' }
        )
      end

      it 'rutea con queries' do
        assert_routing('sugerencias/expansiones',
          { controller: 'sugerencias', action: 'expansiones', term: 'bag' },
          { },
          { term: 'bag' }
        )
      end
    end
    describe 'json' do
      it 'sugiere por nombres' do
        create(:expansion, nombre: 'bogus')
        expansion = create(:expansion, nombre: 'sanata')

        get :expansiones, term: 'sa'

        must_respond_with :success
        json.size.must_equal 1

        llave, valores = json.first

        llave.must_equal expansion.id.to_s
        valores['value'].must_equal expansion.nombre
        valores['label'].must_equal expansion.nombre
        valores['id'].must_equal expansion.id
      end
    end
  end

  describe 'artistas' do
    describe 'rutas' do
      it 'rutea al default' do
        assert_routing(
          { method: :get, path: '/sugerencias/artistas' },
          { controller: 'sugerencias', action: 'artistas' }
        )
      end

      it 'rutea con queries' do
        assert_routing('sugerencias/artistas',
          { controller: 'sugerencias', action: 'artistas', term: 'bag' },
          { },
          { term: 'bag' }
        )
      end
    end
    describe 'json' do
      it 'sugiere por nombres' do
        create(:artista, nombre: 'bogus')
        artista = create(:artista, nombre: 'sanata')

        get :artistas, term: 'sa'

        must_respond_with :success
        json.size.must_equal 1

        llave, valores = json.first

        llave.must_equal artista.id.to_s
        valores['value'].must_equal artista.nombre
        valores['label'].must_equal artista.nombre
      end
    end
  end
end
