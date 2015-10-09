Paperclip.interpolates :cara do |adjunto, estilo|
  if adjunto.instance.archivo_file_name =~ /-.terrenal/
    '-terrenal'
  else
    if adjunto.instance.archivo_file_name =~ /-.infernal/
    '-infernal'
    else
      nil
    end
  end
end

Paperclip.interpolates :cara2 do |adjunto, estilo|
  if adjunto.instance.contracara?
    '-contracara'
  else
    nil
  end
end

class Imagen < ActiveRecord::Base
  belongs_to :version, touch: true, inverse_of: :imagenes

  def contracara?
    !cara
  end

  has_attached_file :archivo,
    url:  "/system/cartas/:style/:expansion/:numero-:carta:cara.:extension",
    path: ":rails_root/public/system/cartas/:style/:expansion/:numero-:carta:cara.:extension",
    default_url: ":assets/imagen-no-disponible-:style.png",
    styles: {
      arte: "190x190",
      mini: "50%" },
    convert_options: {
      # Remueve información de esquemas de colores y EXIF
      all: '-strip' },
    processors: [ :cartas ]

  has_attached_file :archivo2,
    url:  "/system/cartas/:style/:expansion/:numero-:carta:cara2.:extension",
    path: ":rails_root/public/system/cartas/:style/:expansion/:numero-:carta:cara2.:extension",
    default_url: ":assets/imagen-no-disponible-:style.png",
    styles: {
      arte: "190x190",
      mini: "50%" },
    convert_options: {
      # Remueve información de esquemas de colores y EXIF
      all: '-strip' },
    processors: [ :cartas ]

  validates :archivo,
    attachment_content_type: { content_type: %w{image/jpeg image/png} }
  validates :archivo2,
    attachment_content_type: { content_type: %w{image/jpeg image/png} }
end

class ActualizarPathImagenes < ActiveRecord::Migration
  def up
    Imagen.all.each do |imagen|
      if File.exists?(imagen.archivo.path)
        f = File.open(imagen.archivo.path)
        imagen.archivo2 = f
        imagen.save

        if imagen.version.demonio?
          File.delete imagen.archivo.path
        end

        f.close
      end
    end
  end

  def down
    # Nada
  end
end
