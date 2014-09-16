BibliotecaDelEter::Application.routes.draw do

  mount Forem::Engine, at: '/antesala'

  if Rails.env.development?
    mount MailPreview => 'mail'
  end

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
  get 'legales'   => 'inicio#legales'
  get 'cambios/(:fecha)' => 'inicio#cambios', as: :cambios, fecha: /201[2,3,4]|recientes/
  get 'cambios/recientes' => 'inicio#cambios', as: :cambios_recientes
  get 'canon'     => 'inicio#canon'
  get 'arena'     => 'inicio#arena'
  get 'herejias'  => 'inicio#herejias'

  get 'mazos'   => 'mazos#todo'
  get 'listas'  => 'listas#todo'
  get 'disenos' => 'disenos#todo'

  scope path: 'sugerencias', controller: 'sugerencias' do
    get 'cartas/(:filtro)', to: 'sugerencias#cartas', as: :sugerir_cartas
    get 'expansiones', to: 'sugerencias#expansiones', as: :sugerir_expansiones
    get 'artistas', to: 'sugerencias#artistas', as: :sugerir_artistas
    get 'versiones', to: 'sugerencias#versiones', as: :sugerir_versiones
    get 'usuarios', to: 'sugerencias#usuarios', as: :sugerir_usuarios
    get 'valores_expansion_saga'
    get 'valores_version_tipo'
    get 'valores_version_subtipo'
    get 'valores_version_supertipo'
    get 'valores_version_rareza'
    get 'valores_torneo_juez_principal'
    get 'valores_tienda_nombre'
    get 'valores_inscripcion_codigo'
    get 'valores_inscripcion_participante'
  end

  # Rutas en castellano (i.e. cartas/nueva, cartas/2/editar)
  masculinos  = { new: "nuevo", edit: "editar" }
  femeninos   = { new: "nueva", edit: "editar" }

  with_options path_names: femeninos do |r|

    r.resources :cartas, except: [ :edit ] do
      r.resources :versiones, only: [ :new, :edit, :destroy ]
      get ':expansion', to: 'cartas#show', as: :en_expansion, on: :member
    end

    r.resources :expansiones do
      member do
        get 'info'
        get 'sobre'
      end
    end

    # Buscar documentos (search documents)
    r.resource :busqueda, only: [:new, :show, :create] do
      collection do
        match 'cartas' => 'cartas#buscar', via: [:get, :post], as: :cartas
      end
    end

    r.resources :tiendas
  end

  with_options path_names: masculinos do |r|
    r.resources :artistas, except: [ :new, :create, :edit, :update, :delete ]

    r.resources :formatos

    r.resources :torneos do
      member do
        put 'dropear/:inscripcion_id', to: 'torneos#dropear', as: :dropear_del

        get 'rondas/nueva(.:format)',
          to: 'torneos#nueva_ronda', as: :nueva_ronda
        post 'rondas(.:format)',
          to: 'torneos#crear_ronda', as: :crear_ronda
        get 'rondas/:numero(.:format)',
          to: 'torneos#mostrar_ronda', as: :ronda
        delete 'rondas(.:format)',
          to: 'torneos#deshacer_ronda', as: :ultima_ronda
      end
    end

    # Tiene que ir último para evitar conflictos por el path nulo
    r.resources :usuarios, path: '', only: [ :show, :update ] do
      collection do
        get 'socios' => 'usuarios#index', as: ''
      end

      member do
        get 'panel'
        get 'carnet'
        get 'avatar'
      end

      resources :listas, path_names: femeninos do
        member do
          put 'update_slot'
        end
      end

      r.resources :mazos do
        member do
          get 'copiar'
        end
      end

      r.resources :disenos

      resource :coleccion, path_names: femeninos,
        only: [ :show, :update, :edit ] do
        get :faltantes
        get :sobrantes
        put 'update_slot'
      end

      resource :reserva, path_names: femeninos, only: [ :show, :update, :edit ] do
        put 'update_slot'
      end
    end
  end
end
