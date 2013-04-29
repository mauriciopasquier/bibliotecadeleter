# encoding: utf-8
require "./test/test_helper"

describe Usuario do
  it "must be valid" do
    build_stubbed(:usuario).valid?.must_equal true
  end

  it "debe crear la Colección" do
    coleccion = create(:usuario).coleccion
    coleccion.wont_be_nil
    coleccion.coleccion?.must_equal true
    coleccion.nombre.must_equal "Colección"
  end
end
