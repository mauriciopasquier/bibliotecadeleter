# encoding: utf-8
class ApplicationDecorator < Draper::Base

  # TODO Armarlo con las funciones de tags para evitar el != en haml
  def hash_a_dl(hash, *clases)
    clase = clases.extract_options!
    html = "<dl #{clase[:dt].present? ? "class='#{clase[:dl]}'" : nil}>"
    hash.each_pair do |dt, dd|
      html << "<dt #{clase[:dt].present? ? "class='#{clase[:dt]}'" : nil}>#{dt.humanize}</dt>"

      if dd.instance_of? Array
        dd.each do |item|
          html << "<dd #{clase[:dd].present? ? "class='#{clase[:dd]}'" : nil}>#{item}</dd>"
        end
      else
        html << "<dd #{clase[:dd].present? ? "class='#{clase[:dd]}'" : nil}>#{dd}</dd>"
      end

    end
    html << '</dl>'
  end

end
