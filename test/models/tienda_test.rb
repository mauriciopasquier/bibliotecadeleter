# encoding: utf-8
require "./test/test_helper"

describe Tienda do
  it "es válida" do
    build(:tienda).valid?.must_equal true
  end
end
