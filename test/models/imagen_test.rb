# encoding: utf-8
require './test/test_helper'

describe Imagen do
  it 'es válida' do
    build_stubbed(:imagen).must_be :valid?
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

  describe '#cara' do
    it 'es verdadera por default' do
      build(:imagen).cara.must_equal true
    end

    it 'sabe si es cara' do
      build(:imagen).must_be :cara?
      build(:imagen, cara: false).wont_be :cara?
    end

    it 'tiene su opuesto en #contracara' do
      build(:imagen, cara: false).must_be :contracara?
    end
  end
end
