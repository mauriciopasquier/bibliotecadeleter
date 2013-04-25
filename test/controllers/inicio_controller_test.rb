# encoding: utf-8
require "./test/test_helper"

describe InicioController do

  # Este test no funciona por usar authenticated routes. Se testea con un test
  # de integración. Ver https://github.com/plataformatec/devise/issues/1670
  it "debe acceder a bienvenida anónimamente" do
    # assert_routing '/', { controller: 'inicio', action: 'bienvenida' }
  end

  # Este test no funciona por usar authenticated routes. Se testea con un test
  # de integración. Ver https://github.com/plataformatec/devise/issues/1670
  it "debe acceder al panel si está logueado" do
    # loguearse
    # assert_routing '/', { controller: 'inicio', action: 'panel' }
  end

end
