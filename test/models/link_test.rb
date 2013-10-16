# encoding: utf-8
require "./test/test_helper"

describe Link do
  it "es válido" do
    build(:link).valid?.must_equal true
  end

  it "inflecciona bien" do
    "linkeable".pluralize.must_equal "linkeables"
    "linkeables".singularize.must_equal "linkeable"

    "link".pluralize.must_equal "links"
    "links".singularize.must_equal "link"
  end
end
