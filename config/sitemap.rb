Sitemap::Generator.instance.load host: 'bibliotecadeleter.com.ar' do

  path :root, priority: 1

  resources :artistas, priority: 0.9

  resources :cartas, priority: 0.8

  resources :expansiones, priority: 0.7

  path :busqueda, priority: 0.6
  path :cartas_busqueda, priority: 0.6

  path :legales, priority: 0.5
end
