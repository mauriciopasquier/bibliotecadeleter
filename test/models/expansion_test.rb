# encoding: utf-8
require "./test/minitest_helper"

describe Expansion do
  it "must be valid" do
    build(:expansion).valid?.must_equal true
  end
end
