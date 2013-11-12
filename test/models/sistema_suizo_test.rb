# encoding: utf-8
require "./test/test_helper"

describe SistemaSuizo do

  describe '#estricto' do
    it 'es estricto por default' do
      SistemaSuizo.new(Array.new(8)).estricto.must_equal true
    end
  end

  describe 'es estricto' do
    describe '#rondas' do
      it 'para menos de 8 son 0 rondas' do
        (0..7).each do |inscriptos|
          SistemaSuizo.new(Array.new(inscriptos), true).rondas.must_equal 0
        end
      end

      it 'cantidad a partir de 8 inscriptos' do
        [ [8, 3],
          [9, 4], [13, 4], [16, 4],
          [17, 5], [27, 5], [32, 5],
          [33, 6], [45, 6], [64, 6],
          [65, 7], [80, 7], [128, 7],
          [150, 7]
        ].each do |inscriptos, rondas|
          SistemaSuizo.new(Array.new(inscriptos), true).rondas.must_equal rondas
        end
      end
    end
  end

  describe 'no es estricto' do
    describe '#rondas' do
      it 'tira rondas todos para menos de 8' do
        [ [0, 0], [1, 0],
          [2, 1],
          [3, 2], [4, 2],
          [5, 3], [6, 3], [7, 3],
        ].each do |inscriptos, rondas|
          SistemaSuizo.new(Array.new(inscriptos), false).rondas.must_equal rondas
        end
      end
    end
  end
end
