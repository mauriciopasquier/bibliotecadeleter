# encoding: utf-8
require "./test/test_helper"

describe Suplente do
  it 'deriva sus atributos del mazo' do
    mazo = build(:mazo, usuario_id: 1)
    mazo.build_principal
    suplente = mazo.build_suplente

    suplente.mazo.wont_be_nil
    suplente.nombre.must_be_nil
    suplente.usuario_id.must_equal mazo.usuario_id

    mazo.valid?.must_equal true

    suplente.nombre.wont_be_nil
    suplente.nombre.must_equal "1-#{mazo.nombre}-suplente"
  end
end
