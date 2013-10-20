# encoding: utf-8
require './test/test_helper'

describe VersionDecorator do

  describe '#control' do
    before do
      @deco = build(:version).decorate
      @usuario = create(:usuario)
    end

    it 'genera el marcado necesario para agregar/remover' do
      [ :coleccion, :reserva ].each do |tipo|

        render text: @deco.control(@usuario.send(tipo), 'Texto')

        [ ".control-#{tipo} .update-listas.agregar",
          ".control-#{tipo} span.cantidad",
          ".control-#{tipo} .update-listas.remover"
        ].each { |selector| selector.must_select response_from_page }
      end
    end
  end

  describe '#preparar' do
    subject { build(:version).decorate }

    it 'se devuelve decorada' do
      subject.preparar.must_be_same_as subject
    end

    it 'construye una imagen' do
      subject.preparar.imagenes.size.must_equal 1
    end

    it 'construye una segunda imagen si es demonio' do
      demonio_con_una_imagen = build(:version,
        imagenes: [ build(:imagen) ], supertipo: 'Demonio').decorate

      demonio_con_una_imagen.preparar.imagenes.size.must_equal 2
    end
  end
end
