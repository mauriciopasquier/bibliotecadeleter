# encoding: utf-8
class VersionesController < ApplicationController
  load_and_authorize_resource :carta
  load_and_authorize_resource through: :carta

  before_filter :check_espia

  def new
    respond_with(@carta)
  end

  def edit
    respond_with(@carta, @version)
  end

  def destroy
    @version.destroy
    respond_with(@carta, @version, location: @carta)
  end
end
