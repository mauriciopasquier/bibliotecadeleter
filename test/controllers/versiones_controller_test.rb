# encoding: utf-8
require "./test/test_helper"

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
    autorizar { get :new, carta_id: create(:version_con_carta).carta }
    assert_response :success
  end

  it "debe acceder a edit si tiene permisos" do
    loguearse
    version = create(:version_con_carta)
    autorizar { get :edit, carta_id: version.carta, id: version }
    assert_response :success
  end

  it "no debe acceder a edit anónimamente" do
    version = create(:version_con_carta)
    get :edit, carta_id: version.carta, id: version
    assert_redirected_to :root
  end

  it "no debe destruir una version anónimamente" do
    version = create(:version_con_carta)
    delete :destroy, carta_id: version.carta, id: version
    assert_redirected_to :root
  end
end
