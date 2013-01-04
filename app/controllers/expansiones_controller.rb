class ExpansionesController < ApplicationController

  load_and_authorize_resource

  def index
    @expansiones = @expansiones.decorate
    respond_with(@expansiones)
  end

  def show
    @expansion = @expansion.decorate
    respond_with(@expansion)
  end

  def new
    @expansion = @expansion.decorate
    respond_with(@expansion)
  end

  def edit
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
