# encoding: utf-8
class ApplicationDecorator < Draper::Base

  # TODO Armarlo con las funciones de tags para evitar el != en haml
  def hash_a_dl(*hash)
    clase = hash.extract_options!
    html = "<dl #{clase[:dl].present? ? "class='#{clase[:dl]}'" : nil}>"
    hash.first.each_pair do |dt, dd|
      html << "<dt #{clase[:dt].present? ? "class='#{clase[:dt]}'" : nil}>#{dt.humanize}</dt>"

      Array.wrap(dd).each do |item|
        html << "<dd #{clase[:dd].present? ? "class='#{clase[:dd]}'" : nil}>#{item}</dd>"
      end

    end
    html << '</dl>'
  end

end
