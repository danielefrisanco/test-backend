# frozen_string_literal: true

require 'test_helper'

class ListaDeTareasControllerTest < ActionDispatch::IntegrationTest
  include RSpec::Matchers
  setup do
    @lista_de_tarea = lista_de_tareas(:one)
  end

  test 'should get index' do
    get lista_de_tareas_url
    assert_response :success
    expect(@controller.instance_variable_get(:@lista_de_tareas_pasadas))
      .to_not be_nil
    expect(@controller.instance_variable_get(:@lista_de_tareas_pasadas).count)
      .to eq 2
    expect(@controller.instance_variable_get(:@lista_de_tareas_pendientes))
      .to be_empty
    expect(@controller.instance_variable_get(:@lista_de_tareas_futuras))
      .to be_empty
  end

  test 'should get new' do
    get new_lista_de_tarea_url
    assert_response :success
  end
  test 'with non overlapping dates should create lista_de_tarea' do
    assert_difference('ListaDeTarea.count') do
      post lista_de_tareas_url, params:
          { lista_de_tarea: { fecha_de_fin: Time.now + 1.day,
                              fecha_de_inicio: Time.now + 1.hour,
                              titulo: 'Tarea test' } }
    end

    assert_redirected_to lista_de_tarea_url(ListaDeTarea.last)
  end

  test 'with overlapping dates should not create lista_de_tarea' do
    assert_no_difference('ListaDeTarea.count') do
      post lista_de_tareas_url, params:
          { lista_de_tarea: { fecha_de_fin: @lista_de_tarea.fecha_de_fin,
                              fecha_de_inicio: @lista_de_tarea.fecha_de_inicio,
                              titulo: @lista_de_tarea.titulo } }
    end

    assert_response :success
    expect(response.body).to match 'Una otra tarea es solapadas en el tiempo'
  end

  test 'should show lista_de_tarea' do
    get lista_de_tarea_url(@lista_de_tarea)
    assert_response :success
  end

  test 'should get edit' do
    get edit_lista_de_tarea_url(@lista_de_tarea)
    assert_response :success
  end

  test 'with non overlapping dates should not update lista_de_tarea' do
    patch lista_de_tarea_url(@lista_de_tarea), params: {
      lista_de_tarea: {
        fecha_de_fin: Time.now + 1.day,
        fecha_de_inicio: Time.now + 1.hour,
        titulo: 'Test update'
      }
    }
    assert_redirected_to lista_de_tarea_url(@lista_de_tarea)
  end

  test 'with overlapping dates should not update lista_de_tarea' do
    patch lista_de_tarea_url(@lista_de_tarea), params: {
      lista_de_tarea: {
        fecha_de_fin: @lista_de_tarea.fecha_de_fin,
        fecha_de_inicio: @lista_de_tarea.fecha_de_inicio,
        titulo: 'Test update'
      }
    }
    assert_response :success
    expect(response.body).to match 'Una otra tarea es solapadas en el tiempo'
  end

  test 'should destroy lista_de_tarea' do
    assert_difference('ListaDeTarea.count', -1) do
      delete lista_de_tarea_url(@lista_de_tarea)
    end

    assert_redirected_to lista_de_tareas_url
  end

  test 'unauthorized user should not get lista_de_tareas_with_statuses' do
    get lista_de_tareas_with_statuses_url
    assert_response :unauthorized
  end

  test 'authorized user should get lista_de_tareas_with_statuses' do
    skip
    get lista_de_tareas_with_statuses_url
    assert_response :success
  end
end
