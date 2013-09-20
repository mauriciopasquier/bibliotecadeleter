# encoding: utf-8
require "./test/test_helper"

describe Imagen do
  it "es válida" do
    build_stubbed(:imagen).valid?.must_equal true
  end

  describe '#arte' do
    it 'toca a los artistas asociados' do
      artista, imagen = create(:artista, updated_at: 2.days.ago), create(:imagen)
      vieja_key = artista.cache_key

      imagen.arte = artista.nombre

      vieja_key.wont_equal artista.reload.cache_key
    end

    it 'asocia varios artistas' do
      artistas, imagen = [], create(:imagen)
      3.times { artistas << build(:artista) }
      # Como viene desde el usuario
      nombres = artistas.collect(&:nombre).sort.join(', ')
      imagen.arte = nombres

      imagen.artistas.count.must_equal 3
      imagen.arte.must_equal nombres
    end
  end
end
