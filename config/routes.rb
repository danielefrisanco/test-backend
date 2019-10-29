Rails.application.routes.draw do
  resources :lista_de_tareas

  root 'lista_de_tareas#index'
end
