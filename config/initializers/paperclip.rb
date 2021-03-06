# encoding: utf-8
# Defino interpolaciones para los adjuntos
Paperclip.interpolates :expansion do |adjunto,  estilo|
  adjunto.instance.version.expansion.to_param
end

Paperclip.interpolates :numero do |adjunto, estilo|
  adjunto.instance.version.numero_normalizado
end

Paperclip.interpolates :carta do |adjunto, estilo|
  adjunto.instance.version.carta.to_param
end

Paperclip.interpolates :cara do |adjunto, estilo|
  if adjunto.instance.contracara?
    '-contracara'
  else
    nil
  end
end

Paperclip.interpolates :assets do |adjunto,  estilo|
  Rails.application.config.assets.prefix
end

Paperclip.interpolates :slug do |adjunto, estilo|
  adjunto.instance.slug
end
