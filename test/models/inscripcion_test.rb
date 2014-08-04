# encoding: utf-8
require "./test/test_helper"

describe Inscripcion do
  it 'es válida' do
    build(:inscripcion).valid?.must_equal true
  end

  it 'al principio no ha dropeado' do
    build(:inscripcion).dropeo?.must_equal false
  end

  describe '#puntos' do
    it 'suma todas las rondas' do
      create(:inscripcion, rondas_attributes: {
        '0' => attributes_for(:ronda, numero: 1, puntos: 1),
        '1' => attributes_for(:ronda, numero: 2, puntos: 2),
        '2' => attributes_for(:ronda, numero: 3, puntos: 3)
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

  describe '#dropear_o_deshacer' do
    subject { create(:inscripcion) }

    it 'dropea en la última ronda' do
      mock = MiniTest::Mock.new.expect(:ultima_ronda, 2)

      subject.stub :torneo, mock do
        subject.dropear_o_deshacer.must_equal true
        mock.verify
        subject.dropeo.must_equal 2
      end
    end

    it 'deshace el dropeo' do
      subject.dropeo = 1
      subject.dropear_o_deshacer.must_equal false
      subject.dropeo.must_be_nil
      subject.dropeo?.must_equal false
    end
  end

  describe '.posicionadas' do
    subject { Inscripcion }

    let(:tercera) do
      create(:inscripcion, rondas_attributes: {
        '0' => attributes_for(:ronda, puntos: 3, partidas_ganadas: 3)
      })
    end

    let(:segunda) do
      create(:inscripcion, rondas_attributes: {
        '0' => attributes_for(:ronda, puntos: 3, partidas_ganadas: 3)
      })
    end

    let(:primera) do
      primera = create(:inscripcion, rondas_attributes: {
        '0' => attributes_for(:ronda, puntos: 3, partidas_ganadas: 3)
      })
    end

    it 'ordena por puntos' do
      tercera.rondas.first.update puntos: 1
      segunda.rondas.first.update puntos: 2
      primera.rondas.first.update puntos: 3

      subject.posicionadas.first.must_equal primera
      subject.posicionadas.second.must_equal segunda
      subject.posicionadas.third.must_equal tercera
    end

    it 'ordena por puntos y después por partidas ganadas' do
      tercera.rondas.first.update partidas_ganadas: 1
      segunda.rondas.first.update partidas_ganadas: 2
      primera.rondas.first.update partidas_ganadas: 3

      subject.posicionadas.first.must_equal primera
      subject.posicionadas.second.must_equal segunda
      subject.posicionadas.third.must_equal tercera
    end

    it 'ordena por puntos, partidas ganadas y por último desempata' do
      tercera.update desempate: 1
      segunda.update desempate: 2
      primera.update desempate: 3

      subject.posicionadas.first.must_equal primera
      subject.posicionadas.second.must_equal segunda
      subject.posicionadas.third.must_equal tercera
    end
  end
end
