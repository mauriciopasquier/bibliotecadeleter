class SugerenciasController < ApplicationController

  skip_authorization_check
  respond_to :json

  def cartas
    case params[:filtro]
      when 'canonicas'
        autocompletar_canonicas
      when 'demonios'
        autocompletar_demonios
      else
        autocompletar filtro(Carta.con_todo, :nombre), :version_id, :nombre_y_expansion
    end
  end

  def versiones
    #autocompletar_columnas :tipo, :supertipo, :subtipo
  end

  def expansiones
    autocompletar filtro(Expansion, :nombre), :id, :nombre
    #autocompletar_columnas :saga
  end

  def artistas
    autocompletar filtro(Artista, :nombre), :id, :nombre
  end

  private

    # Busca y restringe
    def filtro(modelo, columna, restriccion = { })
      if term.present?
        modelo.where(restriccion).where(sendas_pedidas).where(
          modelo.arel_table[columna].matches("%#{term}%")
        ).limit(10)
      else
        modelo.none
      end
    end

    # Arma el json y lo devuelve
    def autocompletar(resultados, llave, valor)
      h = resultados.inject({}) do |hash, elem|
        hash[elem.send(llave)] = {
          label: elem.send(valor),
          value: elem.send(valor),
          version_id: elem.send(llave)
        }
        hash
      end
      render json: h
    end

    def autocompletar_canonicas
      resultados = filtro Carta.con_todo, :nombre, { versiones: { canonica: true } }
      autocompletar resultados, :version_id, :nombre_y_expansiones
    end

    def autocompletar_demonios
      resultados = filtro Carta.con_todo, :nombre, { versiones: { supertipo: 'Demonio' } }
      autocompletar resultados, :version_id, :nombre_y_expansion
    end

    def sendas_pedidas
      if (sendas = Array.wrap(params[:sendas])).any?
        { versiones: { senda: sendas.map(&:capitalize) } }
      else
        { }
      end
    end

    def term
      params[:term]
    end
end
