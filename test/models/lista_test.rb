# encoding: utf-8
require "./test/test_helper"

describe Lista do
  it "must be valid" do
    build_stubbed(:lista).valid?.must_equal true
  end

  it 'debe calcular la cantidad de cartas en todos los slots' do
    lista = create(:lista_con_slots, cantidad: 5)
    lista.slots.inject(0) {|t, s| t += s.cantidad }.must_equal lista.cantidad
  end
end
