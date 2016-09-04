# encoding: utf-8
require './test/test_helper'

describe Lista do
  it 'es válida' do
    build(:lista).must_be :valid?
  end

  it 'calcula la cantidad de cartas en todos los slots' do
    lista = create(:lista_con_slots, cantidad: 5)
    lista.slots.inject(0) { |t, s| t += s.cantidad }.must_equal lista.cantidad
  end

  describe '#slot_attributes' do
    subject { create(:lista) }

    it 'guarda si no hay repeticiones' do
      slots = { slots_attributes: {
        '0' => attributes_for(:slot, cantidad: 1, version_id: 1),
        '1' => attributes_for(:slot, cantidad: 1, version_id: 2) }
      }

      subject.update_attributes(slots)

      subject.reload.cantidad.must_equal 2
      subject.slots.count.must_equal 2
      subject.slots.where(version_id: 1).size.must_equal 1
      subject.slots.where(version_id: 1).first.cantidad.must_equal 1
      subject.slots.where(version_id: 2).size.must_equal 1
      subject.slots.where(version_id: 2).first.cantidad.must_equal 1
    end

    it 'junta los slots por versión' do
      slots = { slots_attributes: {
        '0' => attributes_for(:slot, cantidad: 1, version_id: 1),
        '1' => attributes_for(:slot, cantidad: 1, version_id: 2),
        '2' => attributes_for(:slot, cantidad: 1, version_id: 1) }
      }

      subject.update_attributes(slots)

      subject.reload.cantidad.must_equal 3
      subject.slots.where(version_id: 1).first.cantidad.must_equal 2
      subject.slots.where(version_id: 1).size.must_equal 1
      subject.slots.count.must_equal 2
    end

    it 'junta los slots por versión destruyendo todos menos uno' do
      lista = create(:lista, slots_attributes: {
        '0' => attributes_for(:slot, cantidad: 1, version_id: 1),
        '1' => attributes_for(:slot, cantidad: 1, version_id: 2),
        '2' => attributes_for(:slot, cantidad: 1, version_id: 1)
      })
      existentes = lista.slots.inject({}) do |slots, slot|
        slots[slot.id] = {
          cantidad: slot.cantidad, version_id: slot.version_id, id: slot.id
        } and slots
      end

      lista.update_attributes slots_attributes: existentes.merge({
        '7' => attributes_for(:slot, cantidad: 1, version_id: 1),
        '8' => attributes_for(:slot, cantidad: 1, version_id: 2),
        '9' => attributes_for(:slot, cantidad: 1, version_id: 1)
      })

      lista.reload.cantidad.must_equal 6
      lista.slots.where(version_id: 1).first.cantidad.must_equal 4
      lista.slots.where(version_id: 1).size.must_equal 1
      lista.slots.where(version_id: 2).first.cantidad.must_equal 2
      lista.slots.where(version_id: 2).size.must_equal 1
      lista.slots.count.must_equal 2
    end

    it 'no suma los marcados para destruir' do
      slots = { slots_attributes: {
        '0' => attributes_for(:slot, cantidad: 1, version_id: 1),
        '1' => attributes_for(:slot, cantidad: 1, version_id: 2),
        '2' => attributes_for(:slot, cantidad: 1, version_id: 2),
        '3' => attributes_for(:slot, cantidad: 1, version_id: 1, _destroy: 'true') }
      }

      subject.update_attributes(slots)

      subject.reload.cantidad.must_equal 3
      subject.slots.count.must_equal 2
      subject.slots.where(version_id: 1).first.cantidad.must_equal 1
      subject.slots.where(version_id: 1).size.must_equal 1
      subject.slots.where(version_id: 2).first.cantidad.must_equal 2
      subject.slots.where(version_id: 2).size.must_equal 1
    end
  end
end
