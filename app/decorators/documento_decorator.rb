# encoding: utf-8
class DocumentoDecorator < ApplicationDecorator
  decorates_association :searchable

  def contenido(enfasis = '')
    h.link_to h.highlight(extracto, enfasis,
      highlighter: '<strong class="text-info">\1</strong>'
    ), recurso_path
  end

  def tipo
    case object.searchable_type
      when 'Version'  then 'Carta'
      else
        object.searchable_type
    end
  end

  def link_al_recurso
    h.link_to_mostrar(recurso_path, nombre)
  end

  def nombre
    case object.searchable_type
      when 'Usuario'  then recurso.nick
      else
        recurso.nombre
    end
  end

  private

    def recurso_path
      @recurso_path ||= case object.searchable_type
        when 'Version'
          h.en_expansion_carta_path(recurso.carta, recurso.expansion)
        when 'Lista', 'Mazo'
          h.url_for [ recurso.usuario, recurso ]
        else
          h.url_for recurso
      end
    end

    def recurso
      object.searchable
    end

    def extracto
      @extracto ||= if object.respond_to?(:extracto)
        object.extracto
      else
        h.excerpt(object.content, enfasis, radius: 50)
      end
    end
end
