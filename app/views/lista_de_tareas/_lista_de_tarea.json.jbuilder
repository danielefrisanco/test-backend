# frozen_string_literal: true

json.extract! lista_de_tarea, :id, :titulo, :fecha_de_inicio, :fecha_de_fin, :created_at, :updated_at
json.url lista_de_tarea_url(lista_de_tarea, format: :json)
