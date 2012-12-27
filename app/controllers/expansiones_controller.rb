class ExpansionesController < ApplicationController
  def index
    respond_with(@expansiones)
  end

  def show
    respond_with(@expansion)
  end

  def new
    respond_with(@expansion)
  end

  def edit
  end

  def create
    @expansion.save
    respond_with(@expansion)
  end

  def update
    @expansion.update_attributes(params[:expansion])
    respond_with(@expansion)
  end

  def destroy
    @expansion.destroy
    respond_with(@expansion)
  end
end
