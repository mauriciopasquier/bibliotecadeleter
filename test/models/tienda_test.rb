# encoding: utf-8
require './test/test_helper'

describe Tienda do
  it 'es válida' do
    build(:tienda).must_be :valid?
  end
end
