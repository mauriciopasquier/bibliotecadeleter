# encoding: utf-8
require "./test/minitest_helper"

describe VersionesController do

  it "debe acceder al index anónimamente" do
    get :index, carta_id: create(:carta)
    assert_response :success
    assert_not_nil assigns(:versiones)
  end

  it "no debe acceder a new anónimamente" do
    get :new, carta_id: create(:carta)
    assert_redirected_to :root
  end

  it "debe acceder a new si tiene permisos" do
    loguearse
    get :new, carta_id: create(:carta)
    assert_response :success
  end

  it "debe crear una version si tiene permisos" do
    loguearse
    carta = create(:carta)
    expansion = create(:expansion)
    assert_difference('Version.count') do
      post :create, carta_id: carta,
                    version: attributes_for(:version,
                                            expansion_id: expansion.id)
    end

    assert_redirected_to carta_version_path(carta, assigns(:version))
  end

  it "no debe crear una version anónimamente" do
    post :create, carta_id: create(:carta), version: attributes_for(:version)
    assert_redirected_to :root
  end

  it "debe mostrar una version anónimamente" do
    version = create(:version_con_carta)
    get :show, carta_id: version.carta, id: version
    assert_response :success
  end

  it "debe acceder a edit si tiene permisos" do
    loguearse
    version = create(:version_con_carta)
    get :edit, carta_id: version.carta, id: version
    assert_response :success
  end

  it "no debe acceder a edit anónimamente" do
    version = create(:version_con_carta)
    get :edit, carta_id: version.carta, id: version
    assert_redirected_to :root
  end

  it "debe actualizar una version si tiene permisos" do
    loguearse
    version = create(:version_con_carta)
    atributos = attributes_for(:version, canonica: true)
    put :update, carta_id: version.carta, id: version, version: atributos
    assert_redirected_to carta_version_path(version.carta, assigns(:version))
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
    assert_equal atributos[:canonica], version.canonica, "No actualiza si es canonica"
  end

  it "no debe actualizar una version anónimamente" do
    version = create(:version_con_carta)
    put :update, carta_id: version.carta, id: version, version: attributes_for(:version)
    assert_redirected_to :root
  end

  it "no debe destruir una version anónimamente" do
    version = create(:version_con_carta)
    delete :destroy, carta_id: version.carta, id: version
    assert_redirected_to :root
  end

end
