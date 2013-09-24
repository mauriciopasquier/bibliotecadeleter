# encoding: utf-8
require "./test/test_helper"

describe Slot do
  it "es válido" do
    build(:slot).valid?.must_equal true
  end
end
