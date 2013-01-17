module Paginar
  def paginar(pagina = 1, cantidad = 10)
    pagina(pagina).per(cantidad)
  end
end
