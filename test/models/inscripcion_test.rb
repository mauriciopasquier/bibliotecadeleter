# encoding: utf-8
require "./test/test_helper"

describe Inscripcion do
  it "es válida" do
    build(:inscripcion).valid?.must_equal true
  end
end
