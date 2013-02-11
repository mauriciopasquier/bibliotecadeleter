# encoding: utf-8
require "./test/minitest_helper"

describe Version do
  it "must be valid" do
    create(:version_con_carta).valid?.must_equal true
  end

  it "debe crear una version huérfana" do
    create(:version_con_carta, expansion: nil).slug.must_match /huerfanas/
  end

  it "debe crearse sólo una versión canónica" do
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
end
