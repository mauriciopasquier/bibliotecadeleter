Rails.application.configure do
  config.sitio_oficial = 'http://inferno.com.ar'
  config.posiciones = "#{config.sitio_oficial}/posiciones.php"

  config.nondigested_assets = %w{
    application.js application.css favicon.png favicon144.png
  }
end
