BibliotecaDelEter::Application.routes.draw do

  root to: 'inicio#bienvenida'

  # TODO patchear devise para cambiar nested path_names (i.e. password/new)
  devise_for :usuarios,
    path: 'recepcion',
    path_names: {
      sign_in: 'entrar',
      sign_out: 'salir',
      password: 'clave',
      confirmation: 'verificacion',
      unlock: 'desbloquear',
      registration: 'carnet',
      sign_up: 'nuevo',
      new: 'nueva',
      cancel: 'cancelar',
      edit: 'editar'
    },
    controllers: {
      registrations: 'registrations'
    }

  # Estáticas al principio por prioridad sobre los recursos sin scope
  get 'legales' => 'inicio#legales'
  get 'panel' => 'inicio#panel'

  scope path: 'sugerencias', controller: 'sugerencias' do
    get 'cartas/(:filtro)', to: 'sugerencias#cartas', as: :sugerir_cartas
    get 'expansiones', to: 'sugerencias#expansiones', as: :sugerir_expansiones
    get 'artistas', to: 'sugerencias#artistas', as: :sugerir_artistas
    get 'valores_expansion_saga'
    get 'valores_version_tipo'
    get 'valores_version_subtipo'
    get 'valores_version_supertipo'
    get 'valores_version_rareza'
  end

  # Rutas en castellano (i.e. cartas/nueva, cartas/2/editar)
  masculinos  = { new: "nuevo", edit: "editar" }
  femeninos   = { new: "nueva", edit: "editar" }

  with_options path_names: femeninos do |r|

    r.resource :coleccion,  except: [ :create, :destroy, :new ] do
      get :faltantes
      get :sobrantes
    end
    r.resource :reserva,    only: [ :show, :update ]

    r.resources :cartas, except: [ :edit ] do
      r.resources :versiones, only: [ :new, :edit, :destroy ]

      collection do
        match 'buscar' => 'cartas#buscar', via: [:get, :post], as: :buscar
      end

      get ':expansion', to: 'cartas#show', as: :en_expansion, on: :member
    end

    r.resources :expansiones
  end

  with_options path_names: masculinos do |r|
    r.resources :artistas, except: [ :new, :create, :edit, :update, :delete ]

    # Tiene que ir último para evitar conflictos por el path nulo
    r.resources :usuarios, path: '', only: :show do
      resources :listas, path_names: femeninos
      r.resources :mazos
    end
  end

  if Rails.env.development?
    mount MailPreview => 'mail'
  end
end
