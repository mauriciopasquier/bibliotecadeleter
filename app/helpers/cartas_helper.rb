# encoding: utf-8
module CartasHelper
  # Nombre se usa en los ids y el texto, clave_de_búsqueda es el parámetro para
  # +Ransack+
  def busqueda_check_tag(nombre, clave_de_busqueda)
    label_tag nombre.tableize, class: 'checkbox inline' do
      check_box_tag(  "q[#{clave_de_busqueda}][]",
                      nombre, checkeado?(nombre), id: nombre.tableize) +
      nombre
    end
  end

  def busqueda_simple
    :versiones_tipo_or_versiones_supertipo_or_versiones_subtipo_or_versiones_texto_or_nombre_cont
  end

  def sendas
    %w{ Caos Locura Muerte Poder Neutral }
  end

  private

    def checkeado?(senda)
      if params[:q]
        if params[:q][:versiones_senda_eq_any].present?
          params[:q][:versiones_senda_eq_any].include? senda
        end
      else
        true
      end
    end

end
