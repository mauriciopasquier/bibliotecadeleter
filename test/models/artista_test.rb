# encoding: utf-8
require "./test/minitest_helper"

describe Artista do
  it "must be valid" do
    build(:artista).valid?.must_equal true
  end

  it "debe devolver artistas sin ilustraciones (outer join)" do
    artista_con = create(:artista)
    imagen = create(:imagen)
    artista_con.ilustraciones << imagen
    artista_sin = create(:artista)

    artista_con.ilustraciones.size.must_equal 1
    artista_sin.ilustraciones.size.must_equal 0

    Artista.con_ilustraciones.includes(:ilustraciones).all.size.must_equal 2
  end

end
