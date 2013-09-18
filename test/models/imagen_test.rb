# encoding: utf-8
require "./test/test_helper"

describe Imagen do
  it "must be valid" do
    build_stubbed(:imagen).valid?.must_equal true
  end

  it "toca a los artistas a los que es asociada" do
    artista, imagen = create(:artista), create(:imagen)

    vieja_key = artista.cache_key
    imagen.arte = artista.nombre

    vieja_key.wont_equal artista.reload.cache_key
  end
end
