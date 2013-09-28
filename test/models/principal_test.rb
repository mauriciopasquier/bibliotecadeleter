# encoding: utf-8
require "./test/test_helper"

describe Principal do
  it 'deriva sus atributos del mazo' do
    mazo = build(:mazo, usuario_id: 1)
    principal = mazo.principal

    principal.mazo.wont_be_nil
    principal.usuario_id.must_equal mazo.usuario_id

    mazo.valid?.must_equal true

    principal.nombre.must_equal "1-#{mazo.nombre}-principal"
  end
end
