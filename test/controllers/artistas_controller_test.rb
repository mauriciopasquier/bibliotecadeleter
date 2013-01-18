# encoding: utf-8
require "./test/minitest_helper"

describe ArtistasController do

  it "debe acceder al index anónimamente" do
    get :index
    assert_response :success
    assert_not_nil assigns(:artistas)
  end

  it "no debe acceder a new anónimamente" do
    get :new
    assert_redirected_to :root
  end

  it "debe acceder a new si tiene permisos" do
    loguearse
    get :new
    assert_response :success
  end

  it "debe crear un artista si tiene permisos" do
    loguearse
    assert_difference('Artista.count') do
      post :create, artista: attributes_for(:artista)
    end

    assert_redirected_to artista_path(assigns(:artista))
  end

  it "no debe crear un artista anónimamente" do
    post :create, artista: attributes_for(:artista)
    assert_redirected_to :root
  end

  it "debe mostrar un artista anónimamente" do
    get :show, id: create(:artista)
    assert_response :success
  end

  it "debe acceder a edit si tiene permisos" do
    loguearse
    get :edit, id: create(:artista)
    assert_response :success
  end

  it "no debe acceder a edit anónimamente" do
    get :edit, id: create(:artista)
    assert_redirected_to :root
  end

  it "debe actualizar un artista si tiene permisos" do
    loguearse
    artista = create(:artista)
    atributos = attributes_for(:artista)
    put :update, id: artista, artista: atributos
    assert_redirected_to artista_path(assigns(:artista))
    artista.reload
    assert_equal atributos[:nombre], artista.nombre, "No actualiza el nombre"
  end

  it "no debe actualizar una artista anónimamente" do
    put :update, id: create(:artista), artista: attributes_for(:artista)
    assert_redirected_to :root
  end

  it "no debe destruir una artista anónimamente" do
    delete :destroy, id: create(:artista)
    assert_redirected_to :root
  end

end
