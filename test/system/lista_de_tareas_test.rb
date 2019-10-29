# frozen_string_literal: true

require 'application_system_test_case'

class ListaDeTareasTest < ApplicationSystemTestCase
  setup do
    @lista_de_tarea = lista_de_tareas(:one)
  end

  test 'visiting the index' do
    visit lista_de_tareas_url
    assert_selector 'h1', text: 'Lista De Tareas'
  end

  test 'creating a Lista de tarea' do
    visit lista_de_tareas_url
    click_on 'New Lista De Tarea'

    fill_in 'Fecha de fin', with: @lista_de_tarea.fecha_de_fin
    fill_in 'Fecha de inicio', with: @lista_de_tarea.fecha_de_inicio
    fill_in 'Titulo', with: @lista_de_tarea.titulo
    click_on 'Create Lista de tarea'

    assert_text 'Lista de tarea was successfully created'
    click_on 'Back'
  end

  test 'updating a Lista de tarea' do
    visit lista_de_tareas_url
    click_on 'Edit', match: :first

    fill_in 'Fecha de fin', with: @lista_de_tarea.fecha_de_fin
    fill_in 'Fecha de inicio', with: @lista_de_tarea.fecha_de_inicio
    fill_in 'Titulo', with: @lista_de_tarea.titulo
    click_on 'Update Lista de tarea'

    assert_text 'Lista de tarea was successfully updated'
    click_on 'Back'
  end

  test 'destroying a Lista de tarea' do
    visit lista_de_tareas_url
    page.accept_confirm do
      click_on 'Destroy', match: :first
    end

    assert_text 'Lista de tarea was successfully destroyed'
  end
end
