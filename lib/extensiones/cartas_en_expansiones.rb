module CartasEnExpansiones
  def en_expansiones(ids = [])
    joins(:versiones).where(versiones: { expansion_id: Array.wrap(ids) })
  end
end
