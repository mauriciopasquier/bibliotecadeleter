# encoding: utf-8
require "./test/test_helper"

describe Diseno do
  it "es válido" do
    build(:diseno).valid?.must_equal true
  end
end
