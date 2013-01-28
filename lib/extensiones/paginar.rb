module Paginar
  def paginar(pagina, cantidad)
    pagina(pagina).per(cantidad)
  end
end
