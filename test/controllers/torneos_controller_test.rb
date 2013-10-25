# encoding: utf-8
require "./test/test_helper"

describe TorneosController do
  describe 'anónimamente' do
    it "accede a la lista" do
      get :index
      must_respond_with :success
      assigns(:torneos).wont_be_nil
    end

    it "no accede a new" do
      get :new
      must_redirect_to :root
    end

    it "no crea torneos" do
      post :create, torneo: attributes_for(:torneo)
      must_redirect_to :root
    end

    it "muestra una expansión" do
      get :show, id: create(:torneo)
      must_respond_with :success
    end

    it "no accede a edit" do
      get :edit, id: create(:torneo)
      must_redirect_to :root
    end

    it "no actualiza torneos" do
      put :update, id: create(:torneo), torneo: attributes_for(:torneo)
      must_redirect_to :root
    end

    it "no destruye torneos" do
      delete :destroy, id: create(:torneo)
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

      it "crea torneos con tienda existente" do
        lambda do
          autorizar do
            post :create, torneo: attributes_for(:torneo,
              formato_id: create(:formato).id,
              tienda_id: create(:tienda).id)
          end
        end.must_change 'Torneo.count'

        must_redirect_to torneo_path(assigns(:torneo))
      end

      it "accede a edit" do
        autorizar { get :edit, id: create(:torneo) }
        must_respond_with :success
      end


      it "actualiza una expansión" do
        torneo = create(:torneo)
        atributos = attributes_for(:torneo, fecha: '2010-10-10')
        autorizar { put :update, id: torneo, torneo: atributos }

        must_redirect_to torneo_path(assigns(:torneo))
        torneo.reload.fecha.to_s.must_equal atributos[:fecha]
      end
    end
  end
end
