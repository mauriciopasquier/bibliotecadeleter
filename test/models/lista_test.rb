# encoding: utf-8
require "./test/test_helper"

describe Lista do
  before do
    @lista = Lista.new
  end

  it "must be valid" do
    @lista.valid?.must_equal true
  end
end
