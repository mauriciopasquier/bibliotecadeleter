# encoding: utf-8
require './test/test_helper'

describe ArtistasController do
  let(:artista) { create(:artista) }

  describe 'anónimamente' do
    it 'accede al index' do
      get :index

      must_respond_with :success
      assigns(:artistas).wont_be_nil
    end

    it 'muestra un artista' do
      get :show, id: artista

      must_respond_with :success
    end

    it 'no accede a edit' do
      get :edit, id: artista

      must_redirect_to :root
    end

    it 'no actualiza' do
      put :update, id: artista, artista: attributes_for(:artista)

      must_redirect_to :root
    end

    it 'no destruye' do
      delete :destroy, id: artista

      must_redirect_to :root
    end
  end

  describe 'logueado' do
    before { loguearse }

    describe 'con permisos' do
      it 'accede a edit' do
        autorizar { get :edit, id: artista }

        must_respond_with :success
      end

      it 'actualiza' do
        autorizar { put :update, id: artista, artista: { nombre: 'Juan Salvo' } }

        must_redirect_to assigns(:artista)
        artista.reload.nombre.must_equal 'Juan Salvo'
      end

      it 'destruye' do
        artista.must_be :persisted?

        lambda do
          autorizar { delete :destroy, id: artista }
        end.must_change 'Artista.count', -1

        must_redirect_to artistas_path
      end
    end
  end
end
