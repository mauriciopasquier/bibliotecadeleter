BibliotecaDelEter::Application.routes.draw do

  root to: 'cartas#index'

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

  resources :cartas

end
