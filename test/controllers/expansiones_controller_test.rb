# encoding: utf-8
require "./test/test_helper"

describe ExpansionesController do

  describe 'anónimamente' do
    it "accede a la lista" do
      get :index
      assert_response :success
      assert_not_nil assigns(:expansiones)
    end

    it "no accede a new" do
      get :new
      assert_redirected_to :root
    end

    it "no crea expansiones" do
      post :create, expansion: attributes_for(:expansion)
      assert_redirected_to :root
    end

    it "muestra una expansión" do
      get :show, id: create(:expansion)
      assert_response :success
    end

    it "no accede a edit" do
      get :edit, id: create(:expansion)
      assert_redirected_to :root
    end

    it "no actualiza expansiones" do
      put :update, id: create(:expansion), expansion: attributes_for(:expansion)
      assert_redirected_to :root
    end

    it "no destruye expansiones" do
      delete :destroy, id: create(:expansion)
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

      it "crea expansiones" do
        loguearse
        assert_difference('Expansion.count') do
          autorizar do
            post :create, expansion: attributes_for(:expansion, notas: "yaml: string")
          end
        end

        assert_redirected_to expansion_path(assigns(:expansion))
      end

      it "accede a edit" do
        loguearse
        autorizar { get :edit, id: create(:expansion) }
        assert_response :success
      end


      it "actualiza una expansión" do
        loguearse
        expansion = create(:expansion)
        atributos = attributes_for(:expansion)
        autorizar { put :update, id: expansion, expansion: atributos }
        assert_redirected_to expansion_path(assigns(:expansion))
        expansion.reload
        assert_equal atributos[:nombre], expansion.nombre, "No actualiza el nombre"
        assert_equal atributos[:total], expansion.total, "No actualiza el total"
        assert_equal atributos[:lanzamiento], expansion.lanzamiento,
          "No actualiza la fecha de lanzamiento"
        assert_equal atributos[:presentacion], expansion.presentacion,
          "No actualiza la fecha de presentacion"
        assert_equal atributos[:saga], expansion.saga, "No actualiza la saga"
        assert_equal atributos[:notas], expansion.notas, "No actualiza las notas"
      end
    end
  end
end
