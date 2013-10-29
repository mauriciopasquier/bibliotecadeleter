# encoding: utf-8
require "./test/test_helper"

describe Ronda do
  it 'es válida' do
    build(:ronda).valid?.must_equal true
  end
end
