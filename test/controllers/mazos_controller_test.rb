# encoding: utf-8
require "./test/test_helper"

describe MazosController do

  describe 'logueado' do
    before { @usuario = loguearse }

    it "accede su lista de mazos" do
      get :index, usuario_id: @usuario
      assert_response :success
      assigns(:mazos).wont_be_nil
    end

    it "intenta crear mazos" do
      get :new, usuario_id: @usuario
      must_respond_with :success
      assigns(:mazo).wont_be_nil
    end

    it "crea mazos" do
      lambda do
        post :create, usuario_id: @usuario, mazo: attributes_for(:mazo).merge({
          principal_attributes: {
            slots_attributes: { '0' => attributes_for(:slot, version_id: 1) }
          }
        })
      end.must_change 'Mazo.count'

      must_redirect_to usuario_mazo_path(@usuario, assigns(:mazo))
    end

    it "edita mazos" do
      mazo = create(:mazo, usuario: @usuario)

      get :edit, usuario_id: @usuario, id: mazo
      must_respond_with :success
    end

    it "actualiza mazos" do
      mazo = create(:mazo_con_demonios, usuario: @usuario)

      nuevo_slot = attributes_for(:slot, version_id: 99)
      viejo_slot = {
        id: mazo.slots.first.id,
        cantidad: mazo.slots.first.cantidad.next,
        version_id: mazo.slots.first.version_id }

      mazo.slots.count.must_equal 1
      mazo.suplente.must_be_nil
      mazo.visible.must_equal true

      put :update, usuario_id: @usuario, id: mazo, mazo: {
        visible: false, nombre: 'otro' }.merge(slots_attributes: {
          '0' => nuevo_slot, '1' => viejo_slot },
          suplente_attributes: {
            slots_attributes: { '0' => attributes_for(:slot, version_id: 2) }
          }
        )

      must_redirect_to usuario_mazo_path(@usuario, assigns(:mazo))

      mazo.reload.slots.count.must_equal 2
      mazo.nombre.must_equal 'otro'
      mazo.suplente.wont_be_nil
      mazo.visible.must_equal false
    end

    it "actualiza mazos" do
      mazo = create(:mazo_con_demonios, usuario: @usuario)

      nuevo_slot = attributes_for(:slot)
      nuevo_slot[:version_id].must_be_nil

      put :update, usuario_id: @usuario, id: mazo, mazo: {
        slots_attributes: { '0' => nuevo_slot } }

      must_render_template :edit
      assigns(:mazo).errors.first.wont_be_nil
    end


    it 'copia mazos' do
      otro = create(:usuario)
      mazo = create(:mazo_con_demonios, usuario: otro)

      get :copiar, usuario_id: otro, id: mazo

      (copia = assigns(:mazo)).wont_be_nil

      copia.id.must_be_nil
      copia.principal.wont_be_nil
      copia.principal.id.must_be_nil
      copia.formato_objetivo.must_equal mazo.formato_objetivo
      copia.slots.first.tap do |demonio|
        demonio.cantidad.must_equal mazo.slots.first.cantidad
        demonio.version_id.must_equal mazo.slots.first.version_id
      end
    end
  end
end
