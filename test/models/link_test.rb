# encoding: utf-8
require "./test/minitest_helper"

describe Link do
  it "must be valid" do
    build(:link).valid?.must_equal true
  end
end
