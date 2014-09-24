# encoding: utf-8
require './test/test_helper'

describe ReservasController do
  describe 'logueado' do
    before { @usuario = loguearse }

    it 'accede su reserva' do
      get :show, usuario_id: @usuario

      must_respond_with :success
      assigns(:reserva).must_equal @usuario.reserva
    end

    # La reserva se edita desde colecciones#edit por ahora
    it 'actualiza su reserva' do
      put :update, usuario_id: @usuario, reserva: { visible: true, nombre: 'otro' }

      must_redirect_to edit_usuario_coleccion_path(@usuario)

      @usuario.reload
      @usuario.reserva.nombre.must_equal 'otro'
      @usuario.reserva.must_be :visible?
    end

    it 'no modifica slots mediante la reserva' do
      put :update, usuario_id: @usuario, reserva: {
        slots_attributes: { '0' => attributes_for(:slot) }
      }

      must_redirect_to edit_usuario_coleccion_path(@usuario)

      @usuario.reload
      @usuario.reserva.slots.must_be :empty?
    end

    describe 'slots' do
      let(:version) { create(:version_con_carta) }

      it 'los actualiza directamente' do
        put :update_slot, usuario_id: @usuario, version_id: version.id,
          cantidad: 999, format: :json

        must_respond_with :success
        json['cantidad'].must_equal 999
        @usuario.reload
        @usuario.reserva.slots.first.cantidad.must_equal 999
      end

      it 'los crea si no existían' do
        @usuario.reserva.slots.must_be :empty?

        put :update_slot, usuario_id: @usuario, version_id: version.id,
          cantidad: 1, format: :json

        @usuario.reserva.slots.count.must_equal 1
      end

      it 'los elimina cuando la cantidad es cero' do
        @usuario.reserva.slots.create version: version, cantidad: 1
        @usuario.reserva.slots.count.must_equal 1

        put :update_slot, usuario_id: @usuario, version_id: version.id,
          cantidad: 0, format: :json

        @usuario.reload.reserva.slots.must_be :empty?
      end

      it 'no actualiza los de otros usuarios' do
        otro = create(:usuario)

        put :update_slot, usuario_id: otro, version_id: version.id,
          cantidad: 999, format: :json

        must_respond_with :redirect
        otro.reload.reserva.slots.must_be :empty?
      end
    end
  end
end
