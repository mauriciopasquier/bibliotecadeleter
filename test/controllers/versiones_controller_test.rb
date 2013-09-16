# encoding: utf-8
require "./test/test_helper"

describe VersionesController do
  describe "tiene permisos" do
    before { loguearse }

    it "accede a new" do
      autorizar { get :new, carta_id: create(:version_con_carta).carta }
      assert_response :success
    end

    it "acceder a edit" do
      version = create(:version_con_carta)
      autorizar { get :edit, carta_id: version.carta, id: version }
      assert_response :success
    end

    it "destruye una version" do
      version = create(:version_con_carta)
      delete :destroy, carta_id: version.carta, id: version
      assert_redirected_to version.carta
    end
  end

  describe "no tiene permisos" do
    it "no accede a new" do
      get :new, carta_id: create(:carta)
      assert_redirected_to :root
    end
    it "no accede a edit" do
      version = create(:version_con_carta)
      get :edit, carta_id: version.carta, id: version
      assert_redirected_to :root
    end

    it "no destruye una version" do
      version = create(:version_con_carta)
      delete :destroy, carta_id: version.carta, id: version
      assert_redirected_to :root
    end
  end
end
