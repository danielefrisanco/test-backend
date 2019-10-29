Rails.application.routes.draw do
  resources :lista_de_tareas

  root 'lista_de_tareas#index'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
