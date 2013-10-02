# encoding: utf-8
require "./test/test_helper"

describe RegistrationsController do
  before { @request.env["devise.mapping"] = Devise.mappings[:usuario] }

  it 'hace Socio al usuario recién registrado' do
    post :create, usuario: attributes_for(:usuario)
    usuario = assigns(:usuario)

    usuario.wont_be_nil
    usuario.medallas.include?(SOCIO).must_equal true
  end

  describe 'acepta los campos propios' do
    it 'creando' do
      post :create, usuario: attributes_for(
        :usuario, nombre: 'Juan Salvo', codigo: 54303030, nick: 'El Eternauta'
      )
      usuario = assigns(:usuario)

      usuario.nick.must_equal 'El Eternauta'
      usuario.nombre.must_equal 'Juan Salvo'
      usuario.codigo.must_equal '54303030'
    end

    it 'actualizando' do
      usuario = loguearse

      put :update, id: usuario, usuario: attributes_for(
        :usuario, nombre: 'Juan Salvo', codigo: 54303030, nick: 'El Eternauta',
        current_password: usuario.password
      )

      usuario.reload.nick.must_equal 'El Eternauta'
      usuario.nombre.must_equal 'Juan Salvo'
      usuario.codigo.must_equal '54303030'
    end
  end
end
