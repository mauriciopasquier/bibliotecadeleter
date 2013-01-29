# enconding: utf-8
module Paperclip
  class Cartas < Thumbnail
    # TODO Está metiendo todo en todos los estilos
    # Command :: convert 'arte.jpg[0]' -crop 190x190+83+120 -auto-orient -resize "190x190" -strip
    # Command :: convert 'mini.jpg[0]' -crop 50%+83+120 -auto-orient -resize "50%" -strip
    def transformation_command
      # A menos que el estilo esté definido con "WxH#"
      unless crop?
        [ '-crop',
          "#{@target_geometry}" +
          "#{@current_geometry.horizontal? ? '+163+63' : '+83+120'}"
        ] + super
      end
    end
  end
end
