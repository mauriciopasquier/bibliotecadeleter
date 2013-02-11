Sitemap::Generator.instance.load host: 'bibliotecadeleter.com.ar' do

  path :root, priority: 1

  resources :cartas, priority: 0.8
  path :buscar_cartas, priority: 0.8

  resources :expansiones, priority: 0.7

  resources :artistas, priority: 0.9

  path :legales, priority: 0.5

end
