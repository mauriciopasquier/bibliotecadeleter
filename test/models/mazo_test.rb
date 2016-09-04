# encoding: utf-8
require './test/test_helper'

describe Mazo do
  describe '#reglas' do
    it 'sin formato_objetivo usa reglas falsas' do
      build(:mazo, formato_objetivo: nil).reglas.must_be_instance_of Reglas::Null
    end

    it 'con formato_objetivo usa reglas reales' do
      build(:mazo, formato_objetivo: build(:formato)
      ).reglas.must_be_instance_of Reglas
    end
  end
end
