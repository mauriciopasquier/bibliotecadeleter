# encoding: utf-8
require './test/test_helper'

describe Ronda do
  it 'es válida' do
    build(:ronda).must_be :valid?
  end
end
