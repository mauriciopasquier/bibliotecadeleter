# encoding: utf-8
require "./test/minitest_helper"

describe Artista do
  it "must be valid" do
    build_stubbed(:artista).valid?.must_equal true
  end
end
