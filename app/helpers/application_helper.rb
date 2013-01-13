# encoding: utf-8
module ApplicationHelper

  # Hay que llamarlo con != en haml para que interprete el html
  def mensajes(flash)
    html = "<div class='flash'>"
    flash.each do |tipo, mensaje|
      html << "<div class='message #{tipo == :alert ? :error : tipo}'><p>#{mensaje }</p></div>"
    end
    html << '</div>'
  end

  def titulo
    "Biblioteca Del Eter#{@titulo ? " | #{@titulo}" : nil}"
  end

  def expansiones(scope = :all)
    Expansion.unscoped.send scope
  end

  def artistas(scope = :all)
    Artista.unscoped.send scope
  end

end
