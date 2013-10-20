# encoding: utf-8
require './test/test_helper'

class Modelo; end

class LanzadorDecorator < ApplicationDecorator
  decorates :modelo
end

class ImplementadorDecorator < ApplicationDecorator
  decorates :modelo
  def preparar; self; end
end

describe ApplicationDecorator do
  describe '.preparar' do
    it 'devuelve un modelo nuevo y decorado' do
      nuevo = ImplementadorDecorator.preparar
      nuevo.must_be_instance_of ImplementadorDecorator
      nuevo.object.must_be_instance_of Modelo
    end

    it 'devuelve error si no implementa #preparar' do
      proc { LanzadorDecorator.preparar }.must_raise NoMethodError
    end
  end

  describe '#preparar' do
    it 'la implementación default devuelve error' do
      subclase = LanzadorDecorator.new(Modelo.new)
      proc { subclase.preparar }.must_raise NoMethodError
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
