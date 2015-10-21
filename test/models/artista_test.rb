# encoding: utf-8
require './test/test_helper'

describe Artista do
  let(:artista) { create(:artista) }
  let(:imagen) { create :imagen }

  it 'es válido' do
    build(:artista).valid?.must_equal true
  end

  describe '.con_cantidad' do
    it 'agrega la cantidad de ilustraciones para cada artista' do
      artista.ilustraciones << imagen

      Artista.con_cantidad.each do |resultado|
        resultado.cantidad.must_equal artista.ilustraciones.count
      end
    end

    it 'sólo devuelve artistas con ilustraciones' do
      artista_sin = create :artista

      artista_sin.ilustraciones.count.must_equal 0
      Artista.con_cantidad.must_be :empty?
    end
  end

  describe '.con_ilustraciones' do
    it 'incluye artistas con 0 ilustraciones (outer join)' do
      artista_sin = create :artista

      artista_sin.ilustraciones.count.must_equal 0
      Artista.con_ilustraciones.count.must_equal 1
    end
  end
end
