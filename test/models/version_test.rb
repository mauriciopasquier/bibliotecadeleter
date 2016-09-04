# encoding: utf-8
require './test/test_helper'

describe Version do
  it 'es válida' do
    create(:version_con_carta).must_be :valid?
  end

  it 'no debe crear versiones huérfanas' do
    build(:version_con_carta, expansion: nil).wont_be :valid?
  end

  it 'debe crearse solo una versión canónica' do
    carta = create(:carta, :con_versiones, cantidad_de_versiones: 3)
    versiones = carta.reload.versiones
    versiones.must_include carta.canonica
    versiones.collect(&:canonica).count {|c| c}.must_equal 1
    versiones.collect(&:canonica).count {|c| !c}.must_equal 2
  end

  it 'el coste convertido debe derivarse del coste' do
    version = create(:version_con_carta)
    version.coste_convertido.must_equal Version.coste_convertido(version.coste)
  end

  it 'número es único en la expansión' do
    version = create(:version_con_carta)
    build(:version_con_carta, numero: version.numero,
      expansion: version.expansion
    ).wont_be :valid?
  end

  it 'detecta si es ilimitada' do
    [ build(:version, supertipo: 'Ilimitado'),
      build(:version, supertipo: 'Ilimitada'),
      build(:version, supertipo: 'Ilimitada y más'),
      build(:version, supertipo: 'E Ilimitada')
    ].each do |version|
      version.ilimitada?.must_equal true
    end

    build(:version).ilimitada?.wont_equal true
  end

  describe '#imagenes' do
    subject { create(:version_con_carta) }

    it 'rechaza las que no tienen ni artista ni archivo' do
      lambda do
        subject.update imagenes_attributes: [attributes_for(:imagen, arte: '', archivo: '')]
      end.wont_change 'Imagen.count'
    end

    it 'permite imágenes sólo con datos de artista' do
      lambda do
        subject.update imagenes_attributes: [attributes_for(:imagen, arte: 'Juan Salvo', archivo: '')]
      end.must_change 'Imagen.count'
    end

    describe '#actualizar_path_de_imagenes' do
      it 'regenera el path de las imágenes' do
        viejo = subject.numero_normalizado
        subject.numero = subject.numero + 1

        imagen = MiniTest::Mock.new.expect :actualizar_path, nil,
          [ viejo, subject.numero_normalizado ]

        subject.stub :imagenes, [ imagen ] do
          subject.save
          imagen.verify
        end
      end
    end
  end

  describe 'lista circular' do
    before do
      @expansion = create(:expansion)
      @primera = create(:version_con_carta, numero: 1, expansion: @expansion)
      @segunda = create(:version_con_carta, numero: 2, expansion: @expansion)
      @tercera = create(:version_con_carta, numero: 3, expansion: @expansion)
    end

    it 'devuelve la siguiente relativa' do
      @primera.siguiente.must_equal @segunda
      @segunda.siguiente.must_equal @tercera
    end

    it 'devuelve la siguiente circularmente' do
      @tercera.siguiente.must_equal @primera
    end

    it 'devuelve la anterior relativa' do
      @tercera.anterior.must_equal @segunda
      @segunda.anterior.must_equal @primera
    end

    it 'devuelve la anterior circularmente' do
       @primera.anterior.must_equal @tercera
    end

    it 'funciona con no consecutivas' do
      una = create(:version_con_carta, numero: 50, expansion: @expansion)
      otra = create(:version_con_carta, numero: 150, expansion: @expansion)

      @tercera.siguiente.must_equal una
      una.siguiente.must_equal otra
      otra.siguiente.must_equal @primera

      @primera.anterior.must_equal otra
      otra.anterior.must_equal una
      una.anterior.must_equal @tercera
    end
  end
end
