# encoding: utf-8
class ExpansionesController < ApplicationController

  load_and_authorize_resource

  def index
    @expansiones = @expansiones.decorate
    @titulo = 'Expansiones'
    respond_with(@expansiones)
  end

  def show
    @expansion = @expansion.decorate
    @titulo = @expansion.nombre
    respond_with(@expansion)
  end

  def new
    @expansion = @expansion.decorate
    @titulo = "Nueva expansión"
    respond_with(@expansion)
  end

  def edit
    @expansion = @expansion.decorate
    @titulo = @expansion.nombre
  end

  def create
    @expansion.save
    @expansion = @expansion.decorate
    respond_with(@expansion)
  end

  def update
    @expansion.update_attributes(params[:expansion])
    @expansion = @expansion.decorate
    respond_with(@expansion)
  end

  def destroy
    @expansion.destroy
    @expansion = @expansion.decorate
    respond_with(@expansion)
  end
end
