class BusquedasController < ApplicationController
  has_scope :pagina, default: 1
  has_scope :per, as: :mostrar, using: :cantidad

  skip_authorization_check

  def create
    session.delete(:texto)
    session.merge! parametros_permitidos
    redirect_to busqueda_path
  end

  def show
    @texto = session[:texto]
    @documentos = PgSearch.multisearch(@texto
      ).reorder(
        'searchable_type, pg_search_rank'
      ).includes(
        :searchable
      ).accessible_by(
        current_ability
      ).select("ts_headline(
          pg_search_documents.content,
          plainto_tsquery(
            'spanish', ''' ' || unaccent('#{@texto}') || ' ''' || ':*'),
          'StartSel=\"<strong class=text-info>\", StopSel=\"</strong>\"'
        ) AS extracto"
      )

    unless @texto.nil?
      flash[:error] = Cita.random_para :no_encontrar if @documentos.empty?
    end

    respond_with @documentos
  end

  private

    def parametros_permitidos
      params.require(:busqueda).permit(:texto)
    end
end
