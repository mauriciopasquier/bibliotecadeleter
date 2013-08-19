# encoding: utf-8
require "./test/test_helper"

describe Lista do
  it "must be valid" do
    build_stubbed(:lista).valid?.must_equal true
  end
end
