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
        autocomplete_carta_nombre
    end
  end

  def versiones
    #autocompletar_columnas :tipo, :supertipo, :subtipo
  end

  def expansiones
    #autocomplete :expansion, :nombre, full: true
    #autocompletar_columnas :saga
  end

  def artistas
    #autocomplete :artista, :nombre, full: true
  end

  private

    # Redefinido para no pelear con rails3-jquery-autocomplete por el join
    def autocomplete_carta_nombre(restricciones = { }, metodo = nil)
      metodo ||= :nombre_y_expansion

      resultado = if (t = params[:term]).present?
        c = Carta.con_todo.where(restricciones).where(sendas_pedidas)

        c.where(
          Carta.arel_table[:nombre].matches("%#{params[:term]}%")
        )
      else
        Carta.none
      end.inject({}) do |hash, elem|
        # Hash de id: value
        hash[elem.version_id] = {
          label: elem.send(metodo),
          value: elem.send(metodo),
          version_id: elem.version_id
        }
        hash
      end

      render json: resultado
    end

    def autocompletar_canonicas
      autocomplete_carta_nombre(
        { versiones: { canonica: true } },
        :nombre_y_expansiones)
    end

    def autocompletar_demonios
      autocomplete_carta_nombre(versiones: { supertipo: 'Demonio' })
    end

    def sendas_pedidas
      if (sendas = Array.wrap(params[:sendas])).any?
        { versiones: { senda: sendas.map(&:capitalize) } }
      else
        { }
      end
    end
end
