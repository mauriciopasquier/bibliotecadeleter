# encoding: utf-8
require "./test/test_helper"

describe Carta do
  it "es válida" do
    build(:carta).valid?.must_equal true
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
end
