# encoding: utf-8
require "./test/test_helper"

describe Carta do
  it "must be valid" do
    build(:carta).valid?.must_equal true
  end
end
