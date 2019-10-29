class ListaDeTareaMailer < ApplicationMailer
  def tarea_started
    puts 'daniele'
    @lista_de_tarea = params[:lista_de_tarea]

    mail(to: @lista_de_tarea.correo, subject: "La tarea empieza ahora")
  end
end
