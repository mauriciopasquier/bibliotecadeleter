# encoding: utf-8
class InicioController < ApplicationController
  skip_authorization_check

  def cambios
    render inline: changelog.to_html, layout: 'application'
  end

  private

    def changelog
      archivo = if params[:fecha].present?
        changelog_por_fecha params[:fecha] == 'recientes' ? DateTime.current.year : params[:fecha]
      else
        Rails.root.join('CHANGELOG.mdwn')
      end

      Kramdown::Document.new File.open(archivo).read
    end

    def changelog_por_fecha(fecha)
      Rails.root.join('doc', "CHANGELOG_#{fecha}.mdwn")
    end
end
