# encoding: utf-8
require './test/test_helper'

describe SlotDecorator do
  describe '#preparar' do
    subject { build(:slot).decorate }

    it 'se devuelve a sí mismo' do
      subject.preparar.must_be_same_as subject
    end
  end
end
