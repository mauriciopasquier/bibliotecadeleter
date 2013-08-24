# encoding: utf-8
require "./test/test_helper"

describe Imagen do
  it "must be valid" do
    build_stubbed(:imagen).valid?.must_equal true
  end

  it "toca a los artistas es asociada" do
    artista, imagen = create(:artista), create(:imagen)

    imagen.arte = artista.nombre

    artista.cache_key.wont_equal artista.reload.cache_key
  end
end
