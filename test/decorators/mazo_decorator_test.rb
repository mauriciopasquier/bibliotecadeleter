# encoding: utf-8
require './test/test_helper'

describe MazoDecorator do
  describe '#preparar' do
    subject { build(:mazo).decorate }

    it 'se devuelve a sí mismo' do
      subject.preparar.must_be_same_as subject
    end
  end
end
