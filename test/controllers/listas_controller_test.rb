# encoding: utf-8
require "./test/test_helper"

describe ListasController do

  describe 'logueado' do
    before { @usuario = loguearse }

    it "accede su lista de cartas" do
      get :index, usuario_id: @usuario
      assert_response :success
      assigns(:listas).wont_be_nil
    end

    it "intenta crear listas" do
      get :new, usuario_id: @usuario
      must_respond_with :success
      assigns(:lista).wont_be_nil
    end

    it "crea listas" do
      lambda do
        post :create, usuario_id: @usuario, lista: attributes_for(:lista)
      end.must_change 'Lista.count'

      must_redirect_to usuario_lista_path(@usuario, assigns(:lista))
    end

    it "edita listas" do
      lista = create(:lista_con_slots, usuario: @usuario)

      get :edit, usuario_id: @usuario, id: lista
      must_respond_with :success
    end

    it "actualiza listas" do
      lista = create(:lista_con_slots, usuario: @usuario)

      nuevo_slot = attributes_for(:slot, version_id: 99)
      viejo_slot = {
        id: lista.slots.first.id,
        cantidad: lista.slots.first.cantidad.next,
        version_id: lista.slots.first.id }

      lista.slots.count.must_equal 1
      lista.visible.must_equal true

      put :update, usuario_id: @usuario, id: lista, lista: {
        visible: false, nombre: 'otro' }.merge(slots_attributes: {
          '0' => nuevo_slot, viejo_slot[:id].to_s => viejo_slot }
        )

      must_redirect_to usuario_lista_path(@usuario, assigns(:lista))

      lista.reload
      lista.slots.count.must_equal 2
      lista.nombre.must_equal 'otro'
    end
  end
end
