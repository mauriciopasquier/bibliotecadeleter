# encoding: utf-8
module CartasHelper
  def checkeado?(senda)
    if params[:q]
      if params[:q][:versiones_senda_eq_any].present?
        params[:q][:versiones_senda_eq_any].include? senda
      end
    else
      true
    end
  end

  def busqueda_simple
    :versiones_tipo_or_versiones_supertipo_or_versiones_subtipo_or_versiones_texto_or_nombre_cont
  end
end
