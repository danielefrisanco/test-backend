Rails.application.routes.draw do
  resources :lista_de_tareas
  get 'lista_de_tareas_with_statuses',
      :to => 'lista_de_tareas#lista_de_tareas_with_statuses'

  root 'lista_de_tareas#index'
end
