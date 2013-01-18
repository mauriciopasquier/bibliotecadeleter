BibliotecaDelEter::Application.routes.draw do

  authenticated do
    root to: "inicio#panel"
  end

  unauthenticated do
    root to: 'inicio#bienvenida'
  end

  # TODO patchear devise para cambiar nested path_names (i.e. password/new)
  devise_for :usuarios, path_names: {
    sign_in: 'entrar',
    sign_out: 'salir',
    password: 'clave',
    confirmation: 'verificacion',
    unlock: 'desbloquear',
    registration: 'cuenta',
    sign_up: 'crear',
    new: 'nueva',
    cancel: 'cancelar',
    edit: 'editar'
  }

  # Rutas en castellano (i.e. cartas/nueva, cartas/2/editar)
  masculinos  = { new: "nuevo", edit: "editar" }
  femeninos   = { new: "nueva", edit: "editar" }

  with_options path_names: femeninos do |r|
    r.resources :cartas do
      r.resources :versiones

      collection do
        match 'buscar' => 'cartas#buscar', via: [:get, :post], as: :buscar
      end

    end
    r.resources :expansiones
  end

  with_options path_names: masculinos do |r|
    r.resources :artistas
  end
end
