# encoding: utf-8
require './test/test_helper'

describe SlotDecorator do
  describe '#preparar' do
    subject { build(:slot).decorate }

    it 'se devuelve a sí mismo' do
      subject.preparar.must_be_same_as subject
    end
  end

  describe '#faltantes' do
    subject { create(:slot, cantidad: 4).decorate }
    let(:h) { MiniTest::Mock.new }
    let(:lista) do
      create :lista, slots_attributes: { '0' => { version_id: subject.version_id, cantidad: 2 } }
    end

    it 'compara con la coleccion actual' do
      h.expect :coleccion_actual, lista
      h.expect :t, 'faltantes contadas', ['slots.te_faltan', count: 2]

      subject.stub :h, h do
        subject.faltantes.must_equal 'faltantes contadas'
        h.verify
      end
    end
  end
end
