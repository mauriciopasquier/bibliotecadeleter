# encoding: utf-8
require "./test/test_helper"

describe Expansion do
  it "es válida" do
    build(:expansion).valid?.must_equal true
  end

  it "debe devolver la expansión base" do
    normal = create(:expansion)
    promocional = create(:expansion, nombre: "promocionales-#{normal.nombre}")
    promocional.base.must_equal normal
    normal.base.must_equal normal
  end
end
