# encoding: utf-8
require "./test/test_helper"

describe Usuario do
  it "es válido" do
    build(:usuario).valid?.must_equal true
  end

  describe 'listas personales' do
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

  describe 'medallas' do
    it 'medallas devuelve badges' do
      usuario = create(:usuario)
      usuario.add_badge SOCIO.id
      usuario.badges.must_equal usuario.medallas
    end

    it 'asigna muchas medallas' do
      usuario = create(:usuario)
      usuario.medallas = [SOCIO, BIBLIOTECARIO]
      usuario.medallas.size.must_equal 2
      usuario.medallas.include?(SOCIO).must_equal true
      usuario.medallas.include?(BIBLIOTECARIO).must_equal true
    end
  end
end
