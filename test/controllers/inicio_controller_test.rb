# encoding: utf-8
require "./test/test_helper"

describe InicioController do

  describe 'logueado' do
    before { loguearse }

    it "muestra legales" do
      get :legales
      must_respond_with :success
    end

    it "muestra la bienvenida" do
      get :bienvenida
      must_respond_with :success
    end

    it "entra a su panel" do
      get :panel
      must_respond_with :success
      assigns(:usuario).wont_be_nil
    end
  end

  describe 'anónimamente' do
    it "muestra legales" do
      get :legales
      must_respond_with :success
    end

    it "muestra la bienvenida" do
      get :bienvenida
      must_respond_with :success
    end

    it "no entra al panel" do
      get :panel
      must_redirect_to :root
    end
  end
end
