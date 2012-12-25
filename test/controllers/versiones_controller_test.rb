# encoding: utf-8
require "./test/minitest_helper"

describe VersionesController do

  it "debe acceder al index anónimamente" do
    get :index
    assert_response :success
    assert_not_nil assigns(:versiones)
  end

  it "no debe acceder a new anónimamente" do
    get :new
    assert_redirected_to :root
  end

  it "debe acceder a new si está logueado" do
    loguearse
    get :new
    assert_response :success
  end

  it "debe crear una version si está logueado" do
    loguearse
    assert_difference('Version.count') do
      post :create, version: attributes_for(:version)
    end

    assert_redirected_to version_path(assigns(:version))
  end

  it "no debe crear una version anónimamente" do
    post :create, version: attributes_for(:version)
    assert_redirected_to :root
  end

  it "debe mostrar una version anónimamente" do
    get :show, id: create(:version)
    assert_response :success
  end

  it "debe acceder a edit si está logueado" do
    loguearse
    get :edit, id: create(:version)
    assert_response :success
  end

  it "no debe acceder a edit anónimamente" do
    get :edit, id: create(:version)
    assert_redirected_to :root
  end

  it "debe actualizar una version si está logueado" do
    loguearse
    version = create(:version)
    atributos = attributes_for(:version)
    put :update, id: version, version: atributos
    assert_redirected_to version_path(assigns(:version))
    version.reload
    assert_equal atributos[:texto], version.texto, "No actualiza el texto"
    assert_equal atributos[:tipo], version.tipo, "No actualiza el tipo"
    assert_equal atributos[:supertipo], version.supertipo, "No actualiza el supertipo"
    assert_equal atributos[:subtipo], version.subtipo, "No actualiza el subtipo"
    assert_equal atributos[:fue], version.fue, "No actualiza la fue"
    assert_equal atributos[:res], version.res, "No actualiza la res"
    assert_equal atributos[:senda], version.senda, "No actualiza la senda"
    assert_equal atributos[:ambientacion], version.ambientacion, "No actualiza la ambientacion"
    assert_equal atributos[:numero], version.numero, "No actualiza el numero"
    assert_equal atributos[:rareza], version.rareza, "No actualiza la rareza"
    assert_equal atributos[:coste], version.coste, "No actualiza el coste"
  end

  it "no debe actualizar una version anónimamente" do
    put :update, id: create(:version), version: attributes_for(:version)
    assert_redirected_to :root
  end

  it "debe destruir una version si está logueado" do
    delete :destroy, id: create(:version)
    assert_redirected_to :root
  end

end
