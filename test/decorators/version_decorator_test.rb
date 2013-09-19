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

end
