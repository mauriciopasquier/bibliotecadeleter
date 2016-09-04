# encoding: utf-8
require './test/test_helper'

describe Slot do
  it 'es válido' do
    build(:slot).must_be :valid?
  end

  it 'no se guarda sin versión' do
    slot = build(:slot, version: nil)

    slot.version.must_be_nil
    slot.wont_be :valid?
  end
end
