# encoding: utf-8
require "./test/minitest_helper"

describe Usuario do
  it "must be valid" do
    build_stubbed(:usuario).valid?.must_equal true
  end
end
