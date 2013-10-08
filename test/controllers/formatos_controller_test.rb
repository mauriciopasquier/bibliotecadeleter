# encoding: utf-8
require "./test/test_helper"

describe FormatosController do

  describe 'anónimamente' do
    it "accede a la lista" do
      get :index
      must_respond_with :success
      assigns(:formatos).wont_be_nil
    end

    it "no accede a new" do
      get :new
      must_redirect_to :root
    end

    it "no crea formatos" do
      post :create, formato: attributes_for(:formato)
      must_redirect_to :root
    end

    it "muestra un formato" do
      get :show, id: create(:formato)
      must_respond_with :success
    end

    it "no accede a edit" do
      get :edit, id: create(:formato)
      must_redirect_to :root
    end

    it "no actualiza formatos" do
      put :update, id: create(:formato), formato: attributes_for(:formato)
      must_redirect_to :root
    end

    it "no destruye formatos" do
      delete :destroy, id: create(:formato)
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

      it "crea formatos" do
        lambda do
          autorizar do
            post :create, formato: attributes_for(:formato)
          end
        end.must_change 'Formato.count'

        must_redirect_to formato_path(assigns(:formato))
      end

      it "accede a edit" do
        autorizar { get :edit, id: create(:formato) }
        must_respond_with :success
      end


      it "actualiza un formato" do
        formato, expansion = create(:formato), create(:expansion)
        atributos = attributes_for(:formato, expansion_ids: [expansion.id])

        autorizar { put :update, id: formato, formato: atributos }

        must_redirect_to formato_path(assigns(:formato))
        formato.reload.nombre.must_equal atributos[:nombre], "No actualiza el nombre"
        formato.expansiones.include?(expansion).must_equal true
      end
    end
  end
end
