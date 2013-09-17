# encoding: utf-8
require "./test/test_helper"

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
    autorizar { get :new }
    assert_response :success
  end

  it "debe crear una carta si tiene permisos" do
    loguearse
    assert_difference('Carta.count') do
      autorizar { post :create, carta: attributes_for(:carta) }
    end

    assert_redirected_to carta_path(assigns(:carta))
  end

  it "no debe crear una carta anónimamente" do
    post :create, carta: attributes_for(:carta)
    assert_redirected_to :root
  end

  it "debe mostrar una carta anónimamente" do
    get :show, id: create(:carta_con_versiones)
    assert_response :success
  end

  it "debe mostrar una version anónimamente" do
    version = create(:version_con_carta)
    get :show, id: version.carta, expansion: version.expansion
    assert_response :success
    assigns(:version).must_equal version
  end

  it "debe actualizar una carta si tiene permisos" do
    loguearse
    version = create(:version_con_carta)
    carta = version.carta
    atributos_carta = attributes_for(:carta)
    atributos_version = attributes_for(:version, id: version.id)
    autorizar do
      put :update, id: carta,
        carta: atributos_carta.merge(versiones_attributes: {'0' => atributos_version })
    end
    assert_redirected_to carta_path(assigns(:carta))

    carta.reload
    assert_equal atributos_carta[:nombre], carta.nombre, "No actualiza el nombre"

    version.reload
    assert_equal atributos_version[:texto], version.texto, "No actualiza el texto"
    assert_equal atributos_version[:tipo], version.tipo, "No actualiza el tipo"
    assert_equal atributos_version[:supertipo], version.supertipo, "No actualiza el supertipo"
    assert_equal atributos_version[:subtipo], version.subtipo, "No actualiza el subtipo"
    assert_equal atributos_version[:fue], version.fue, "No actualiza la fue"
    assert_equal atributos_version[:res], version.res, "No actualiza la res"
    assert_equal atributos_version[:senda], version.senda, "No actualiza la senda"
    assert_equal atributos_version[:ambientacion], version.ambientacion, "No actualiza la ambientacion"
    assert_equal atributos_version[:numero], version.numero, "No actualiza el numero"
    assert_equal atributos_version[:rareza], version.rareza, "No actualiza la rareza"
    assert_equal atributos_version[:coste], version.coste, "No actualiza el coste"
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
