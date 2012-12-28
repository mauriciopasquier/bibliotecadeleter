# encoding: utf-8
# Defino interpolaciones para los adjuntos
Paperclip.interpolates :expansion do |adjunto,  estilo|
  adjunto.instance.version.expansion.to_s
end

Paperclip.interpolates :numero do |adjunto, estilo|
  adjunto.instance.version.numero.to_s.rjust(3, '0')
end

Paperclip.interpolates :nombre do |adjunto, estilo|
  adjunto.instance.version.carta.to_s
end
