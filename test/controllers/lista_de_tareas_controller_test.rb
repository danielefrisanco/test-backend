require 'test_helper'

class ListaDeTareasControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lista_de_tarea = lista_de_tareas(:one)
  end

  test "should get index" do
    get lista_de_tareas_url
    assert_response :success
  end

  test "should get new" do
    get new_lista_de_tarea_url
    assert_response :success
  end

  test "should create lista_de_tarea" do
    assert_difference('ListaDeTarea.count') do
      post lista_de_tareas_url, params: { lista_de_tarea: { fecha_de_fin: @lista_de_tarea.fecha_de_fin, fecha_de_inicio: @lista_de_tarea.fecha_de_inicio, titulo: @lista_de_tarea.titulo } }
    end

    assert_redirected_to lista_de_tarea_url(ListaDeTarea.last)
  end

  test "should show lista_de_tarea" do
    get lista_de_tarea_url(@lista_de_tarea)
    assert_response :success
  end

  test "should get edit" do
    get edit_lista_de_tarea_url(@lista_de_tarea)
    assert_response :success
  end

  test "should update lista_de_tarea" do
    patch lista_de_tarea_url(@lista_de_tarea), params: { lista_de_tarea: { fecha_de_fin: @lista_de_tarea.fecha_de_fin, fecha_de_inicio: @lista_de_tarea.fecha_de_inicio, titulo: @lista_de_tarea.titulo } }
    assert_redirected_to lista_de_tarea_url(@lista_de_tarea)
  end

  test "should destroy lista_de_tarea" do
    assert_difference('ListaDeTarea.count', -1) do
      delete lista_de_tarea_url(@lista_de_tarea)
    end

    assert_redirected_to lista_de_tareas_url
  end
end
