# encoding: utf-8
require "./test/test_helper"

describe ExpansionesController do

  it "debe acceder al index anónimamente" do
    get :index
    assert_response :success
    assert_not_nil assigns(:expansiones)
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

  it "debe crear una expansión si tiene permisos" do
    loguearse
    assert_difference('Expansion.count') do
      post :create, expansion: attributes_for(:expansion, notas: "yaml: string")
    end

    assert_redirected_to expansion_path(assigns(:expansion))
  end

  it "no debe crear una expansión anónimamente" do
    post :create, expansion: attributes_for(:expansion)
    assert_redirected_to :root
  end

  it "debe mostrar una expansión anónimamente" do
    get :show, id: create(:expansion)
    assert_response :success
  end

  it "debe acceder a edit si tiene permisos" do
    loguearse
    get :edit, id: create(:expansion)
    assert_response :success
  end

  it "no debe acceder a edit anónimamente" do
    get :edit, id: create(:expansion)
    assert_redirected_to :root
  end

  it "debe actualizar una expansión si tiene permisos" do
    loguearse
    expansion = create(:expansion)
    atributos = attributes_for(:expansion, notas: 'at: at')
    put :update, id: expansion, expansion: atributos
    assert_redirected_to expansion_path(assigns(:expansion))
    expansion.reload
    assert_equal atributos[:nombre], expansion.nombre, "No actualiza el nombre"
    assert_equal atributos[:total], expansion.total, "No actualiza el total"
    assert_equal atributos[:lanzamiento], expansion.lanzamiento,
      "No actualiza la fecha de lanzamiento"
    assert_equal atributos[:presentacion], expansion.presentacion,
      "No actualiza la fecha de presentacion"
    assert_equal atributos[:saga], expansion.saga, "No actualiza la saga"
    assert_equal ({'at' => 'at'}), expansion.notas, "No actualiza las notas"
  end

  it "no debe actualizar una expansión anónimamente" do
    put :update, id: create(:expansion), expansion: attributes_for(:expansion)
    assert_redirected_to :root
  end

  it "no debe destruir una expansión anónimamente" do
    delete :destroy, id: create(:expansion)
    assert_redirected_to :root
  end

end
