# encoding: utf-8
module FichaResponder

  def to_ficha
    @mazo = resource.decorate

    Prawn::Document.generate archivo, template: ficha_en_blanco do |ficha|
    end

    controller.send_file archivo, type: Mime::PDF, filename: nombre
  end

  private

    def ficha_en_blanco
      Rails.root.join('app', 'assets', 'documents', 'ficha-de-registro.pdf')
    end

    def nombre
      "#{@mazo.slug}.pdf"
    end

    def archivo
      "public/system/#{nombre}"
    end
end
