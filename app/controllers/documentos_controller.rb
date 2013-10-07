class DocumentosController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad

  skip_authorization_check

  def new
  end

  def create
    session.delete(:busqueda)
    session.merge! parametros_permitidos
    redirect_to busqueda_index_path
  end

  def index
    @busqueda = session[:busqueda]
    @documentos = PgSearch.multisearch(@busqueda).reorder(
      'searchable_type, pg_search_rank').includes(:searchable)

    respond_with @documentos
  end

  private

    def parametros_permitidos
      params.require(:documento).permit(:busqueda)
    end
end
