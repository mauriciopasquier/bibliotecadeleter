# encoding: utf-8
require './test/test_helper'

describe Carta do
  it 'es válida' do
    build(:carta).must_be :valid?
  end

  describe '#actualizar_path_de_imagenes' do
    subject { build(:carta) }

    it 'regenera el path de las imágenes si cambió el nombre' do
      version = MiniTest::Mock.new.expect :actualizar_path_de_imagenes, nil
      subject.nombre = 'otro'

      subject.stub :versiones, [ version ] do
        subject.save
        version.verify
      end
    end
  end

  describe '#cantidad' do
    subject { create(:carta, :con_versiones, cantidad_de_versiones: 2) }
    let(:lista) { create(:lista) }

    it 'sin especificar una lista la cantidad es 0' do
      subject.cantidad.must_equal 0
      subject.cantidad(nil).must_equal 0
    end

    it 'cuenta todas las versiones' do
      subject.reload.versiones.each do |v|
        lista.slots.create version_id: v.id, cantidad: 3
      end
      subject.cantidad(lista).must_equal 6
    end
  end
end
