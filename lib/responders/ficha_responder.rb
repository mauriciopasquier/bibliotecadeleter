# encoding: utf-8
module FichaResponder

  def to_ficha
    @mazo = FichaDeRegistroDecorator.new resource

    # Empieza con una bounding_box (los márgenes) de 487 x 734
    Prawn::Document.generate archivo, template: ficha_en_blanco do |f|
      f.with_options overflow: :shrink_to_fit, height: 10 do |fo|
        # Metadatos
        fo.text_box @mazo.nombre, at: [ 0, 734 ], width: 150

        # Datos personales
        fo.text_box @mazo.usuario, at: [ 70, 616 ], width: 260
        fo.text_box @mazo.codigo, at: [ 355, 616 ], width: 100

        # Mazo
        fo.text_box @mazo.demonio, at: [195, 562], width: 260

        f.font_size 10 do
          f.column_box [35, 520], columns: 2, width: 450, height: 245 do
            @mazo.cartas.each do |linea|
              fo.text linea.cantidad + ' '*15 + linea.carta, leading: 3
            end
          end
        end

        fo.text_box @mazo.principal_cantidad, at: [ 300, 255 ], width: 50

        # Mazo suplente
        @mazo.suplentes.each do |linea|
        end
        fo.text_box @mazo.suplente_cantidad, at: [ 300, 118 ], width: 50
      end
    end

    controller.send_file archivo, type: Mime::PDF, filename: nombre
  end

  private

    def ficha_en_blanco
      Rails.root.join 'app', 'assets', 'documents', 'ficha-de-registro.pdf'
    end

    def nombre
      "#{@mazo.slug}.pdf"
    end

    def archivo
      Rails.root.join 'public', 'system', nombre
    end
end
