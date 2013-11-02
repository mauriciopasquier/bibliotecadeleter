# encoding: utf-8
require "./test/test_helper"

describe SistemaSuizo do
  describe '#rondas' do
    it 'cantidad según cantidad de inscriptos' do
      [ [0, 0], [7, 0],
        [8, 3],
        [9, 4], [13, 4], [16, 4],
        [17, 5], [27, 5], [32, 5],
        [33, 6], [45, 6], [64, 6],
        [65, 7], [80, 7], [128, 7],
        [150, 7]
      ].each do |inscriptos, rondas|
        SistemaSuizo.new(Array.new(inscriptos)).rondas.must_equal rondas
      end
    end
  end
end
