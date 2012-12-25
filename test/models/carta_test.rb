# encoding: utf-8
require "minitest_helper"

describe Carta do
  it "must be valid" do
    build_stubbed(:carta).valid?.must_equal true
  end
end
