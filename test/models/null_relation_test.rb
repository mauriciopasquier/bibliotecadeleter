# encoding: utf-8
require "./test/test_helper"

describe 'NullRelation' do
  describe Artista do
    it 'debe devolver una relación vacía' do
      Artista.none.must_be_empty
      Artista.none.must_be_kind_of ActiveRecord::Relation
    end
  end

  describe Carta do
    it 'debe devolver una relación vacía' do
      Carta.none.must_be_empty
      Carta.none.must_be_kind_of ActiveRecord::Relation
    end
  end

  describe Expansion do
    it 'debe devolver una relación vacía' do
      Expansion.none.must_be_empty
      Expansion.none.must_be_kind_of ActiveRecord::Relation
    end
  end

  describe Imagen do
    it 'debe devolver una relación vacía' do
      Imagen.none.must_be_empty
      Imagen.none.must_be_kind_of ActiveRecord::Relation
    end
  end

  describe Link do
    it 'debe devolver una relación vacía' do
      Link.none.must_be_empty
      Link.none.must_be_kind_of ActiveRecord::Relation
    end
  end

  describe Usuario do
    it 'debe devolver una relación vacía' do
      Usuario.none.must_be_empty
      Usuario.none.must_be_kind_of ActiveRecord::Relation
    end
  end

  describe Version do
    it 'debe devolver una relación vacía' do
      Version.none.must_be_empty
      Version.none.must_be_kind_of ActiveRecord::Relation
    end
  end
end
