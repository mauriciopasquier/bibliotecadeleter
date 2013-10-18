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
      usuario.badges.must_equal usuario.medallas
    end

    it 'medallas devuelve [] si no está creado el usuario' do
      Usuario.new.medallas.must_equal []
    end

    it 'asigna muchas medallas' do
      usuario = create(:usuario)
      actuales = usuario.medallas.size

      usuario.medallas = [SOCIO, BIBLIOTECARIO]
      usuario.medallas.size.must_equal actuales + 2
      usuario.medallas.include?(SOCIO).must_equal true
      usuario.medallas.include?(BIBLIOTECARIO).must_equal true
    end

    it 'asigna una medalla' do
      usuario = create(:usuario)
      actuales = usuario.medallas.size

      usuario.medallas = SOCIO
      usuario.medallas.size.must_equal actuales + 1
      usuario.medallas.include?(SOCIO).must_equal true
    end
  end

  describe 'código' do
    it 'entra en la tabla' do
      usuario = create(:usuario, codigo: '5430228822')
      usuario.reload.codigo.must_equal '5430228822'
    end
  end
end
