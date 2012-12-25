# encoding: utf-8
require "./test/minitest_helper"

describe Version do
  it "must be valid" do
    build_stubbed(:version).valid?.must_equal true
  end
end
