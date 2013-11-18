# encoding: utf-8
require "./test/test_helper"

describe Sobre do
  subject { Sobre.new }

  describe '.new' do
    it 'tiene defaults comunes' do
      subject.raras.must_equal 1
      subject.infrecuentes.must_equal 3
      subject.comunes.must_equal 6
      subject.proporcion_epica.must_equal 0.2
    end

    it 'acepta parámetros' do
      sobre = Sobre.new raras: 9, infrecuentes: 8, comunes: 7,
        proporcion_epica: 0.9

      sobre.raras.must_equal 9
      sobre.infrecuentes.must_equal 8
      sobre.comunes.must_equal 7
      sobre.proporcion_epica.must_equal 0.9
    end
  end

  describe '.abrir' do
    it 'llama #abrir en una nueva instancia con defaults' do
      nuevo = MiniTest::Mock.new.expect :abrir, 'nada', [['foo', 'bar']]

      Sobre.stub :new, nuevo do
        Sobre.abrir(['foo', 'bar']).must_equal 'nada'
      end
      nuevo.verify
    end
  end

  describe '#rara_o_epica' do
    it 'usa la proporción de épica' do
      proporcion = MiniTest::Mock.new.expect :<=, false, [Float]

      subject.stub :proporcion_epica, proporcion do
        subject.rara_o_epica.must_equal 'Épica'
      end
      proporcion.verify
    end

    it 'puede forzar que sea épica' do
      subject.proporcion_epica = 1

      1000.times do
        subject.rara_o_epica.must_equal 'Épica'
      end
    end

    it 'puede forzar que sea rara' do
      subject.proporcion_epica = 0

      1000.times do
        subject.rara_o_epica.must_equal 'Rara'
      end
    end
  end
end
