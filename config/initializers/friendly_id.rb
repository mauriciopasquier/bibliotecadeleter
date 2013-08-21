FriendlyId.defaults do |config|
  config.use :reserved
  # Reserve words for English and Spanish URLs
  config.reserved_words = %w(
    new edit nueva nuevo editar clave verificacion desbloquear carnet
    cancelar entrar salir expansiones cartas artistas legales cuenta
    coleccion reserva listas)
end
