# encoding: utf-8
require "./test/test_helper"

describe ExpansionesController do

  describe 'anónimamente' do
    it "accede a la lista" do
      get :index
      must_respond_with :success
      assigns(:expansiones).wont_be_nil
    end

    it "no accede a new" do
      get :new
      must_redirect_to :root
    end

    it "no crea expansiones" do
      post :create, expansion: attributes_for(:expansion)
      must_redirect_to :root
    end

    it "muestra una expansión" do
      get :show, id: create(:expansion)
      must_respond_with :success
    end

    it "no accede a edit" do
      get :edit, id: create(:expansion)
      must_redirect_to :root
    end

    it "no actualiza expansiones" do
      put :update, id: create(:expansion), expansion: attributes_for(:expansion)
      must_redirect_to :root
    end

    it "no destruye expansiones" do
      delete :destroy, id: create(:expansion)
      must_redirect_to :root
    end
  end

  describe 'logueado' do
    before { loguearse }
    describe 'con permisos' do
      it "accede a new" do
        autorizar { get :new }
        must_respond_with :success
      end

      it "crea expansiones" do
        lambda do
          autorizar do
            post :create, expansion: attributes_for(:expansion, notas: "yaml: string")
          end
        end.must_change 'Expansion.count'

        must_redirect_to expansion_path(assigns(:expansion))
      end

      it "accede a edit" do
        autorizar { get :edit, id: create(:expansion) }
        must_respond_with :success
      end


      it "actualiza una expansión" do
        expansion = create(:expansion)
        atributos = attributes_for(:expansion)
        autorizar { put :update, id: expansion, expansion: atributos }

        must_redirect_to expansion_path(assigns(:expansion))
        atributos[:nombre].must_equal expansion.reload.nombre, "No actualiza el nombre"
        atributos[:total].must_equal expansion.total, "No actualiza el total"
        atributos[:lanzamiento].must_equal expansion.lanzamiento,
          "No actualiza la fecha de lanzamiento"
        atributos[:presentacion].must_equal expansion.presentacion,
          "No actualiza la fecha de presentacion"
        atributos[:saga].must_equal expansion.saga, "No actualiza la saga"
        atributos[:notas].must_equal expansion.notas, "No actualiza las notas"
      end
    end
  end
end
