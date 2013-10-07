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
        get 'autocompletar_nombre'  => 'cartas#autocomplete_carta_nombre'
        get 'autocompletar_demonios'
        get 'autocompletar_sendas'
        get 'autocompletar_canonicas'
      end

      get ':expansion', to: 'cartas#show', as: :en_expansion, on: :member
    end

    r.resources :expansiones do
      collection do
        get 'autocompletar_nombre'  => 'expansiones#autocomplete_expansion_nombre'
        get 'completar_saga'
      end
    end

    r.resources :versiones, only: [] do
      collection do
        get 'completar_tipo'
        get 'completar_supertipo'
        get 'completar_subtipo'
        get 'completar_rareza'
      end
    end

    # Buscar documentos (search documents)
    r.resource :busqueda, only: [:new, :show, :create] do
      collection do
        match 'cartas' => 'cartas#buscar', via: [:get, :post], as: :cartas
      end
    end
  end

  with_options path_names: masculinos do |r|
    r.resources :artistas, except: [ :new, :create, :edit, :update, :delete ] do
      collection do
        get 'autocompletar_nombre'  => 'artistas#autocomplete_artista_nombre'
      end
    end

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
