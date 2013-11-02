# encoding: utf-8
require "./test/test_helper"

describe Torneo do
  it "es válido" do
    build(:torneo).valid?.must_equal true
  end
end
