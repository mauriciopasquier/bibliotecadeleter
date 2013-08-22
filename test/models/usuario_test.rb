# encoding: utf-8
require "./test/test_helper"

describe Usuario do
  it "must be valid" do
    build(:usuario).valid?.must_equal true
  end

  it "debe crear la Colección" do
    coleccion = create(:usuario).coleccion
    coleccion.wont_be_nil
    coleccion.coleccion?.must_equal true
  end

  it "debe crear la Reserva" do
    reserva = create(:usuario).reserva
    reserva.wont_be_nil
    reserva.reserva?.must_equal true
  end
end
