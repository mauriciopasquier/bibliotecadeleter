# encoding: utf-8
# Defino interpolaciones para los adjuntos
Paperclip.interpolates :expansion do |adjunto,  estilo|
  adjunto.instance.version.expansion.to_param
end

Paperclip.interpolates :numero do |adjunto, estilo|
  adjunto.instance.version.to_param
end

Paperclip.interpolates :carta do |adjunto, estilo|
  adjunto.instance.version.carta.to_param
end
