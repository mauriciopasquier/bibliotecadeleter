# encoding: utf-8
require "./test/minitest_helper"

describe Version do
  it "must be valid" do
    version = create(:carta_con_versiones).versiones.first
    version.valid?.must_equal true
  end
end
