# encoding: utf-8
require "./test/test_helper"

describe Imagen do
  it "must be valid" do
    build_stubbed(:imagen).valid?.must_equal true
  end
end
