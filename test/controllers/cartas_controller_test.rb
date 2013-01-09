# encoding: utf-8
require "./test/minitest_helper"

describe CartasController do

  it "debe acceder al index anónimamente" do
    get :index
    assert_response :success
    assert_not_nil assigns(:cartas)
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

  it "debe crear una carta si tiene permisos" do
    loguearse
    assert_difference('Carta.count') do
      post :create, carta: attributes_for(:carta)
    end

    assert_redirected_to carta_path(assigns(:carta))
  end

  it "no debe crear una carta anónimamente" do
    post :create, carta: attributes_for(:carta)
    assert_redirected_to :root
  end

  it "debe mostrar una carta anónimamente" do
    get :show, id: create(:carta)
    assert_response :success
  end

  it "debe acceder a edit si tiene permisos" do
    loguearse
    get :edit, id: create(:carta)
    assert_response :success
  end

  it "no debe acceder a edit anónimamente" do
    get :edit, id: create(:carta)
    assert_redirected_to :root
  end

  it "debe actualizar una carta si tiene permisos" do
    loguearse
    carta = create(:carta)
    atributos = attributes_for(:carta)
    put :update, id: carta, carta: atributos
    assert_redirected_to carta_path(assigns(:carta))
    carta.reload
    assert_equal atributos[:nombre], carta.nombre, "No actualiza el nombre"
  end

  it "no debe actualizar una carta anónimamente" do
    put :update, id: create(:carta), carta: attributes_for(:carta)
    assert_redirected_to :root
  end

  it "no debe destruir una carta anónimamente" do
    delete :destroy, id: create(:carta)
    assert_redirected_to :root
  end

end
