# enconding: utf-8
module Paperclip
  class Cartas < Thumbnail
    def transformation_command
      # A menos que el estilo esté definido con "WxH#"
      unless crop?
        [ '-crop',
          "#{@target_geometry}" +
          "#{@current_geometry.horizontal? ? '+177+70' : '+90+130'}"
        ] + super
      end
    end
  end
end
