# encoding: utf-8
require "./test/minitest_helper"

describe Version do
  it "must be valid" do
    create(:version_con_carta).valid?.must_equal true
  end

  it "debe crear una version huérfana" do
    create(:version_con_carta, expansion: nil).slug.must_match /huerfanas/
  end
end
