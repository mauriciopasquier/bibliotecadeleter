# encoding: utf-8
class RegistrationsController < Devise::RegistrationsController
  # Controlador especializado para que Merit pueda registrar sus callbacks
  def create
    @usuario = build_resource(sign_up_params)
    super
  end
end
