# encoding: utf-8
require "./test/test_helper"

describe Inscripcion do
  it 'es válida' do
    build(:inscripcion).valid?.must_equal true
  end

  describe '#puntos' do
    it 'suma todas las rondas' do
      create(:inscripcion, rondas_attributes: {
        '0' => attributes_for(:ronda, puntos: 1),
        '1' => attributes_for(:ronda, puntos: 2),
        '2' => attributes_for(:ronda, puntos: 3)
      }).puntos.must_equal 6
    end
  end

  describe '#partidas ganadas' do
    subject do
      create(:inscripcion, rondas_attributes: {
        '0' => attributes_for(:ronda, numero: 1, partidas_ganadas: 2),
        '1' => attributes_for(:ronda, numero: 2, partidas_ganadas: 0),
        '2' => attributes_for(:ronda, numero: 3, partidas_ganadas: 1)
      })
    end

    it 'suma las partidas ganadas' do
      subject.partidas_ganadas.must_equal 3
    end

    describe 'en' do
      it 'informa de las rondas jugadas' do
        subject.partidas_ganadas_en(1).must_equal 2
        subject.partidas_ganadas_en(2).must_equal 0
        subject.partidas_ganadas_en(3).must_equal 1
      end

      it 'devuelve cero en las demás' do
        subject.partidas_ganadas_en(0).must_equal 0
        subject.partidas_ganadas_en(4).must_equal 0
      end
    end
  end

  describe '#ha_jugado_con?' do
    subject { create(:inscripcion) }

    it 'es verdadero si ha jugado' do
      oponente = create(:inscripcion)
      subject.rondas.create(
        attributes_for(:ronda, oponente_id: oponente.id)
      )
      subject.ha_jugado_con?(oponente).must_equal true
    end

    it 'es falso si no ha jugado' do
      subject.ha_jugado_con?(create(:inscripcion)).wont_equal true
    end
  end
end
