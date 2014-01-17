# encoding: utf-8
require "./test/test_helper"

describe Slot do
  it "es válido" do
    build(:slot).valid?.must_equal true
  end

  it 'no se guarda sin versión' do
    slot = build(:slot, version: nil)
    slot.version.must_be_nil
    slot.valid?.wont_equal true
  end
end
