class SugerenciasController < ApplicationController
  autocompletar_valores :expansion, :saga
  autocompletar_valores :version, :tipo, :supertipo, :subtipo

  skip_authorization_check
  respond_to :json

  def cartas
    case params[:filtro]
      when 'canonicas'
        autocompletar_canonicas
      when 'demonios'
        autocompletar_demonios
      else
        autocompletar filtro(Carta.con_todo, :nombre, sendas_pedidas), :version_id, :nombre_y_expansion
    end
  end

  def expansiones
    autocompletar filtro(Expansion, :nombre), :id, :nombre
  end

  def artistas
    autocompletar filtro(Artista, :nombre), :id, :nombre
  end

  private

    def autocompletar_canonicas
      resultados = filtro Carta.con_todo, :nombre, {
        versiones: { canonica: true }
      }.deep_merge(sendas_pedidas)

      autocompletar resultados, :version_id, :nombre_y_expansiones
    end

    def autocompletar_demonios
      resultados = filtro Carta.con_todo, :nombre, {
        versiones: { supertipo: 'Demonio' }
      }.deep_merge(sendas_pedidas)

      autocompletar resultados, :version_id, :nombre_y_expansion
    end

    def sendas_pedidas
      if (sendas = Array.wrap(params[:sendas])).any?
        { versiones: { senda: sendas.map(&:capitalize) } }
      else
        { }
      end
    end
end
