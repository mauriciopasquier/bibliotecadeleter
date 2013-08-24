# encoding: utf-8
require "./test/test_helper"

describe Slot do
  before do
    @slot = Slot.new
  end

  it "must be valid" do
    @slot.valid?.must_equal true
  end
end
