require 'test_helper'

describe CartaDecorator do
  subject { CartaDecorator.new carta }
  let(:carta) { build :carta, nombre: 'una carta' }

  describe '#nombre' do
    it 'devuelve el nombre de la carta' do
      subject.nombre.must_equal carta.nombre
    end

    it 'devuelve nil si no hay nombre' do
      CartaDecorator.new(build(:carta, nombre: nil)).nombre.must_be :nil?
    end

    it 'devuelve el nombre de la primer cara si hay 2' do
      con_dos_caras = build :carta, nombre: 'cara 1 / cara 2'

      CartaDecorator.new(con_dos_caras).nombre.must_equal 'cara 1'
    end
  end
end
