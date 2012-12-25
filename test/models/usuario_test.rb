require "minitest_helper"

describe Usuario do
  before do
    @usuario = Usuario.new
  end

  it "must be valid" do
    @usuario.valid?.must_equal true
  end
end
