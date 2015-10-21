# encoding: utf-8
require './test/test_helper'

describe ImagenDecorator do
  describe '#nombre_de_cara' do
    it 'devuelve el nombre de cada cara' do
      build(:imagen, cara: true).decorate.nombre_de_cara.must_equal 'infernal'
      build(:imagen, cara: false).decorate.nombre_de_cara.must_equal 'terrenal'
    end
  end
end
