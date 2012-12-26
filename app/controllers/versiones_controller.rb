# encoding: utf-8
class VersionesController < ApplicationController
  def index
    respond_with(@versiones)
  end

  def show
    respond_with(@version)
  end

  def new
    respond_with(@version)
  end

  def edit
  end

  def create
    @version.save
    respond_with(@version)
  end

  def update
    @version.update_attributes(params[:version])
    respond_with(@version)
  end

  def destroy
    @version.destroy
    respond_with(@version)
  end
end
