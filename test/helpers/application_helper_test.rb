# encoding: utf-8
require "./test/minitest_helper"

describe ApplicationHelper do

  it "debe transformar a la rareza completa" do
    rareza_completa('C').must_equal 'Común'
    rareza_completa('I').must_equal 'Infrecuente'
    rareza_completa('R').must_equal 'Rara'
    rareza_completa('E').must_equal 'Épica'
    rareza_completa('P').must_equal 'Promocional'
  end

end
