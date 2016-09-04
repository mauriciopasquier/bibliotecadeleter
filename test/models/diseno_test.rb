# encoding: utf-8
require './test/test_helper'

describe Diseno do
  it 'es válido' do
    build(:diseno).must_be :valid?
  end
end
