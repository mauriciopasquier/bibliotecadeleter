# encoding: utf-8
module CartasHelper
  # Nombre se usa en los ids y el texto, parametro es la llave del hash
  # +params+
  def busqueda_check_tag(nombre, parametro, opciones = {})
    label_tag nombre.tableize, class: 'checkbox inline' do
      check_box_tag(parametro, (opciones[:nombre] || nombre),
                    checkeado?((opciones[:nombre] || nombre)),
                    id: nombre.tableize) +
      nombre
    end
  end

  def sendas
    %w{ Caos Locura Muerte Poder Neutral }
  end

  private

    # Revisa el hash params para determinar si el checkbox fue usado en la
    # búsqueda recién realizada
    def checkeado?(nombre)
      if params[:q]
        if params[:q][:versiones_senda_eq_any].present? and sendas.include? nombre
          return params[:q][:versiones_senda_eq_any].include? nombre
        end
        if params[:incluir].present?
          return params[:incluir].include? nombre.to_s
        end
      else
        true
      end
    end

end
