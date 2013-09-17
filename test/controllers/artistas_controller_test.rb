# encoding: utf-8
require "./test/test_helper"

describe ArtistasController do

  describe 'anónimamente' do
    it "accede al index" do
      get :index
      assert_response :success
      assert_not_nil assigns(:artistas)
    end

    it "muestra un artista" do
      get :show, id: create(:artista)
      assert_response :success
    end
  end
end
