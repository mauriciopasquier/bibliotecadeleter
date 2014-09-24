# encoding: utf-8
require './test/test_helper'

describe ColeccionesController do
  describe 'logueado' do
    before { @usuario = loguearse }

    it 'accede su colección' do
      get :show, usuario_id: @usuario

      must_respond_with :success
      assigns(:coleccion).must_equal @usuario.coleccion
    end

    it 'edita su colección y su reserva' do
      get :edit, usuario_id: @usuario

      must_respond_with :success
      assigns(:coleccion).must_equal @usuario.coleccion
    end

    it 'actualiza su colección' do
      put :update, usuario_id: @usuario, coleccion: { visible: true, nombre: 'otro' }

      must_redirect_to edit_usuario_coleccion_path(@usuario)

      @usuario.reload
      @usuario.coleccion.nombre.must_equal 'otro'
      @usuario.coleccion.must_be :visible?
    end

    it 'no modifica slots mediante la colección' do
      put :update, usuario_id: @usuario, coleccion: {
        slots_attributes: { '0' => attributes_for(:slot) }
      }

      must_redirect_to edit_usuario_coleccion_path(@usuario)

      @usuario.reload
      @usuario.coleccion.slots.must_be :empty?
    end

    describe 'slots' do
      let(:version) { create(:version_con_carta) }

      it 'los actualiza directamente' do
        put :update_slot, usuario_id: @usuario, version_id: version.id,
          cantidad: 999, format: :json

        must_respond_with :success
        json['cantidad'].must_equal 999
        @usuario.reload
        @usuario.coleccion.slots.first.cantidad.must_equal 999
      end

      it 'los crea si no existían' do
        @usuario.coleccion.slots.must_be :empty?

        put :update_slot, usuario_id: @usuario, version_id: version.id,
          cantidad: 1, format: :json

        @usuario.coleccion.slots.count.must_equal 1
      end

      it 'los elimina cuando la cantidad es cero' do
        @usuario.coleccion.slots.create version: version, cantidad: 1
        @usuario.coleccion.slots.count.must_equal 1

        put :update_slot, usuario_id: @usuario, version_id: version.id,
          cantidad: 0, format: :json

        @usuario.reload.coleccion.slots.must_be :empty?
      end

      it 'no actualiza los de otros usuarios' do
        otro = create(:usuario)

        put :update_slot, usuario_id: otro, version_id: version.id,
          cantidad: 999, format: :json

        must_respond_with :redirect
        otro.reload.coleccion.slots.must_be :empty?
      end
    end
  end
end
