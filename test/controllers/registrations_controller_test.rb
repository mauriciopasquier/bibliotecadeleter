# encoding: utf-8
require "./test/test_helper"

describe RegistrationsController do
  it 'hace Socio al usuario recién registrado' do
    @request.env["devise.mapping"] = Devise.mappings[:usuario]

    post :create, usuario: attributes_for(:usuario)
    usuario = assigns(:usuario)

    usuario.wont_be_nil
    usuario.medallas.include?(SOCIO).must_equal true
  end
end
