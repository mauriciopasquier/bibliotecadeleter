# encoding: utf-8
require "./test/test_helper"

describe FormatosController do

  describe 'anónimamente' do
    it "accede a la lista" do
      get :index
      assert_response :success
      assert_not_nil assigns(:formatos)
    end

    it "no accede a new" do
      get :new
      assert_redirected_to :root
    end

    it "no crea formatos" do
      post :create, formato: attributes_for(:formato)
      assert_redirected_to :root
    end

    it "muestra una expansión" do
      get :show, id: create(:formato)
      assert_response :success
    end

    it "no accede a edit" do
      get :edit, id: create(:formato)
      assert_redirected_to :root
    end

    it "no actualiza formatos" do
      put :update, id: create(:formato), formato: attributes_for(:formato)
      assert_redirected_to :root
    end

    it "no destruye formatos" do
      delete :destroy, id: create(:formato)
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

      it "crea formatos" do
        loguearse
        assert_difference('Formato.count') do
          autorizar do
            post :create, formato: attributes_for(:formato)
          end
        end

        assert_redirected_to formato_path(assigns(:formato))
      end

      it "accede a edit" do
        loguearse
        autorizar { get :edit, id: create(:formato) }
        assert_response :success
      end


      it "actualiza una expansión" do
        loguearse
        formato = create(:formato)
        atributos = attributes_for(:formato)
        autorizar { put :update, id: formato, formato: atributos }
        assert_redirected_to formato_path(assigns(:formato))
        formato.reload
        assert_equal atributos[:nombre], formato.nombre, "No actualiza el nombre"
      end
    end
  end
end
