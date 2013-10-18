# encoding: utf-8
require "./test/test_helper"

describe Version do
  it "es válida" do
    create(:version_con_carta).valid?.must_equal true
  end

  it "debe crear una version huérfana" do
    create(:version_con_carta, expansion: nil).slug.must_match /huerfanas/
  end

  it "debe crearse solo una versión canónica" do
    carta = create(:carta_con_versiones, cantidad_de_versiones: 3)
    versiones = carta.versiones.all
    versiones.must_include carta.canonica
    versiones.collect(&:canonica).count {|c| c}.must_equal 1
    versiones.collect(&:canonica).count {|c| !c}.must_equal 2
  end

  it "el coste convertido debe derivarse del coste" do
    version = create(:version_con_carta)
    version.coste_convertido.must_equal Version.coste_convertido(version.coste)
  end

  it "número es único en la expansión" do
    version = create(:version_con_carta)
    build(:version_con_carta, numero: version.numero,
      expansion: version.expansion).valid?.must_equal false
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
