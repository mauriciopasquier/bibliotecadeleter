BibliotecaDelEter::Application.routes.draw do

  root to: 'cartas#index'

  devise_for :usuarios
end
