# encoding: utf-8
require './test/test_helper'

describe Usuario do
  it 'es válido' do
    build(:usuario).must_be :valid?
  end

  describe 'sus listas personales' do
    subject { create(:usuario) }

    it 'incluyen una Colección' do
      subject.coleccion.wont_be_nil
      subject.coleccion.must_be :coleccion?
    end

    it 'incluyen una Reserva' do
      subject.reserva.wont_be_nil
      subject.reserva.must_be :reserva?
    end

    it 'son privadas inicialmente' do
      subject.coleccion.wont_be :visible?
      subject.reserva.wont_be :visible?
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
