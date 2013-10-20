# encoding: utf-8
require './test/test_helper'

class Modelo; end

class LanzadorDecorator < ApplicationDecorator
  decorates :modelo
end

class ImplementadorDecorator < ApplicationDecorator
  decorates :modelo
  def preparar
    self
  end
end

describe ApplicationDecorator do

  describe 'la subclase no implementa' do
    subject { LanzadorDecorator.new(Modelo.new) }

    describe '.preparar' do
      it 'lanza NoMethodError' do
        proc { LanzadorDecorator.preparar }.must_raise NoMethodError
      end
    end

    describe '#preparar' do
      it 'lanza NoMethodError' do
        proc { subject.preparar }.must_raise NoMethodError
      end
    end
  end

  describe 'la subclase implementa' do
    subject { ImplementadorDecorator.new(Modelo.new) }
    let(:nuevo) { ImplementadorDecorator.preparar }

    describe '.preparar' do
      it 'devuelve un modelo decorado' do
        nuevo.must_be_instance_of ImplementadorDecorator
        nuevo.object.must_be_instance_of Modelo
      end
    end

    describe '#preparar' do
      it 'prepara el objeto y se devuelve' do
        subject.preparar.must_be_same_as subject
      end
    end
  end

  describe '#nil_cycle' do
    let(:d) { ApplicationDecorator.new(Modelo.new) }
    it 'mantiene nil en el ciclo' do
      d.nil_cycle(nil, 'string', name: :test).must_be_nil
      d.nil_cycle(nil, 'string', name: :test).must_equal 'string'
      d.nil_cycle(nil, 'string', name: :test).must_be_nil
    end
  end

  # TODO testear que ciertas medallas habiliten poner links y stuff
  describe '#markdown_seguro' do
    subject { ApplicationDecorator.new(Modelo.new) }

    it 'devuelve una cadena vacía si no hay input' do
      [ [], '', nil ].each do |nada|
        subject.markdown_seguro(nada).must_equal '', "Falla con #{nada}"
      end
    end

    it 'blanquea todo por default' do
      subject.markdown_seguro(
        "<a href='http://somewhere.evil'>bla</a> <script>implode();</script>"
      ).must_match '<a>bla</a>'
    end
  end
end
