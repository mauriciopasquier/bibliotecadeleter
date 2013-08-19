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
    coleccion.nombre.must_equal "Tu colección"
  end

  it "debe crear el Total" do
    total = create(:usuario).total
    total.wont_be_nil
    total.total?.must_equal true
    total.nombre.must_equal "Todas tus cartas"
  end
end
