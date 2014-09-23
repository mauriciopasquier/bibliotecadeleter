# encoding: utf-8
require './test/test_helper'

describe ListasController do
  describe 'logueado' do
    before { @usuario = loguearse }

    it 'accede su lista de cartas' do
      get :index, usuario_id: @usuario
      assert_response :success
      assigns(:listas).wont_be_nil
    end

    it 'intenta crear listas' do
      get :new, usuario_id: @usuario
      must_respond_with :success
      assigns(:lista).wont_be_nil
    end

    it 'crea listas' do
      lambda do
        post :create, usuario_id: @usuario, lista: attributes_for(:lista)
      end.must_change 'Lista.count'

      must_redirect_to usuario_lista_path(@usuario, assigns(:lista))
    end

    it 'edita listas' do
      lista = create(:lista_con_slots, usuario: @usuario)

      get :edit, usuario_id: @usuario, id: lista
      must_respond_with :success
    end

    it 'actualiza listas' do
      lista = create(:lista_con_slots, usuario: @usuario, visible: true, nombre: 'uno')

      put :update, usuario_id: @usuario, id: lista, lista: { visible: false, nombre: 'otro' }

      must_redirect_to usuario_lista_path(@usuario, assigns(:lista))

      lista.reload
      lista.nombre.must_equal 'otro'
      lista.visible.must_equal false
    end

    it 'actualiza slots mediante la lista' do
      lista = create(:lista_con_slots, usuario: @usuario)

      lista.slots.count.must_equal 1
      viejo_slot = lista.slots.first
      nuevo_slot = attributes_for(:slot, version_id: 99)

      put :update, usuario_id: @usuario, id: lista, lista: {
        slots_attributes: {
          '0' => nuevo_slot,
          '1' => { id: viejo_slot.id, cantidad: 999 }
        }
      }

      must_redirect_to usuario_lista_path(@usuario, assigns(:lista))

      lista.reload
      lista.slots.count.must_equal 2
      viejo_slot.reload.cantidad.must_equal 999
    end

    it 'rechaza slots vacíos' do
      lista = create(:lista_con_slots, usuario: @usuario)
      nuevo_slot = attributes_for(:slot)

      nuevo_slot[:version_id].must_be_nil

      put :update, usuario_id: @usuario, id: lista, lista: {
        slots_attributes: { '0' => nuevo_slot } }

      must_render_template :edit
      assigns(:lista).errors.first.wont_be_nil
    end
  end
end
