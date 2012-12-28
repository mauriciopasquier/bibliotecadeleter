# encoding: utf-8
# Defino interpolaciones para los adjuntos
Paperclip.interpolates :expansion do |adjunto,  estilo|
  adjunto.instance.version.expansion.slug
end

Paperclip.interpolates :numero do |adjunto, estilo|
  adjunto.instance.version.decorate.numero_justificado
end

Paperclip.interpolates :nombre do |adjunto, estilo|
  adjunto.instance.version.slug
end
