module VersionesContadas
  def contadas
    select('versiones.*, sum(slots.cantidad) as total').group('versiones.id')
  end

  def con_total(operacion, valor)
    contadas.having("sum(slots.cantidad) #{operacion} ?", valor)
  end
end
