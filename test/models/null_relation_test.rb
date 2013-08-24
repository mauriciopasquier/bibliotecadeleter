# encoding: utf-8
require "./test/test_helper"

describe 'NullRelation' do
  it 'debe devolver una relación vacía' do
    Carta.none.must_be_empty
    Carta.none.must_be_kind_of ActiveRecord::Relation
  end
end
