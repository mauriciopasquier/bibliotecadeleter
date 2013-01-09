# encoding: utf-8
require "./test/minitest_helper"

describe Artista do
  it "must be valid" do
    build_stubbed(:artista).valid?.must_equal true
  end

  it "debe devolver artistas sin ilustraciones (outer join)" do
    artista_con = create(:artista)
    ilustracion = create(:version_con_carta)
    ilustracion.artistas << artista_con
    artista_sin = create(:artista)

    artista_con.ilustraciones.size.must_equal 1
    artista_sin.ilustraciones.size.must_equal 0

    Artista.con_ilustraciones.all.size.must_equal 2
  end

end
