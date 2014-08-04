# encoding: utf-8
require "./test/test_helper"

describe CartasController do
  describe 'anónimamente' do
    it "accede a la lista" do
      get :index
      assert_response :success
      assert_not_nil assigns(:cartas)
    end

    it "no accede a new" do
      get :new
      assert_redirected_to :root
    end

    it "no crea cartas" do
      post :create, carta: attributes_for(:carta)
      assert_redirected_to :root
    end

    it "muestra una carta" do
      get :show, id: create(:carta, :con_versiones)
      assert_response :success
    end

    it "muestra una carta según la expansión" do
      version = create(:version_con_carta)
      get :show, id: version.carta, expansion: version.expansion
      assert_response :success
      assigns(:version).must_equal version
    end

    it "no actualiza cartas" do
      put :update, id: create(:carta), carta: attributes_for(:carta)
      assert_redirected_to :root
    end

    it "no destruye cartas" do
      delete :destroy, id: create(:carta)
      assert_redirected_to :root
    end
  end

  describe 'logueado' do
    describe 'con permisos' do
      it "accede a new" do
        loguearse
        autorizar { get :new }
        assert_response :success
      end

      it "crea cartas" do
        loguearse
        assert_difference('Carta.count') do
          autorizar { post :create, carta: attributes_for(:carta) }
        end

        assert_redirected_to carta_path(assigns(:carta))
      end

      it "actualiza una carta" do
        loguearse
        version = create(:version_con_carta)
        carta = version.carta
        atributos_carta = attributes_for(:carta)
        atributos_version = attributes_for(:version, id: version.id)
        autorizar do
          put :update, id: carta,
            carta: atributos_carta.merge(versiones_attributes: {'0' => atributos_version })
        end
        assert_redirected_to en_expansion_carta_path(assigns(:carta), version.expansion)

        carta.reload
        assert_equal atributos_carta[:nombre], carta.nombre, "No actualiza el nombre"

        version.reload
        assert_equal atributos_version[:texto], version.texto, "No actualiza el texto"
        assert_equal atributos_version[:tipo], version.tipo, "No actualiza el tipo"
        assert_equal atributos_version[:supertipo], version.supertipo, "No actualiza el supertipo"
        assert_equal atributos_version[:subtipo], version.subtipo, "No actualiza el subtipo"
        assert_equal atributos_version[:fue], version.fue, "No actualiza la fue"
        assert_equal atributos_version[:res], version.res, "No actualiza la res"
        assert_equal atributos_version[:senda], version.senda, "No actualiza la senda"
        assert_equal atributos_version[:ambientacion], version.ambientacion, "No actualiza la ambientacion"
        assert_equal atributos_version[:numero], version.numero, "No actualiza el numero"
        assert_equal atributos_version[:rareza], version.rareza, "No actualiza la rareza"
        assert_equal atributos_version[:coste], version.coste, "No actualiza el coste"
      end
    end
  end
end
