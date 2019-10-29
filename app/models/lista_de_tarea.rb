# frozen_string_literal: true

# Wrong name, Tarea would be the correct name
class ListaDeTarea < ApplicationRecord
  validates_presence_of :titulo, :fecha_de_inicio, :fecha_de_fin
  validate :fin_despues_inicio
  validate :unique_range_of_fechas
  validate :email_format
  after_save :send_email
  # The tareas divided per status
  # @return [<ListaDeTarea>, <ListaDeTarea>, <ListaDeTarea>]
  # pasadas, pendientes, futuras Three lists of tareas
  def self.by_status
    pasadas = []
    pendientes = []
    futuras = []
    tareas_with_status = ListaDeTarea.all
    tareas_with_status.each do |tarea|
      pasadas << tarea if tarea.status == :pasada
      pendientes << tarea if tarea.status == :pendiente
      futuras << tarea if tarea.status == :futura
    end
    [pasadas, pendientes, futuras]
  end

  # The tarea to json tth the status
  # @return [Hash] Json of the tarea with the status
  def json_with_status
    as_json.merge(status: status)
  end

  # Status of the tarea
  # @return [Symbol] status the status of the tarea
  def status
    now = Time.now
    return :pasada if now >= fecha_de_fin
    return :pendiente if now >= fecha_de_inicio && now <= fecha_de_fin
    return :futura if now < fecha_de_inicio
  end


  # Creates the job to send a new mail if email or start time have changed
  def send_email
    if correo.present? && (saved_changes.include?(:correo) ||
                           saved_changes.include?(:fecha_de_inicio))
      puts ListaDeTareaMailer.with(lista_de_tarea: self)
                        .tarea_started
                        .deliver_later(wait_until: fecha_de_inicio)
    end
  end

  private

  # Adds an error when the end date is before the start date
  def fin_despues_inicio
    if fecha_de_fin < fecha_de_inicio
      errors.add(:fecha_de_fin,
                 'La fecha de fin debe ser despues la fecha de inicio')
    end
  end

  # Adds an error when the date range collides with the range of another tarea
  def unique_range_of_fechas
    ListaDeTarea.all.each do |tarea|
      next unless tarea != self && !(tarea.fecha_de_fin < fecha_de_inicio ||
                             tarea.fecha_de_inicio > fecha_de_fin)

      errors.add(:fechas, 'Una otra tarea es solapadas en el tiempo')
      break
    end
  end

  # Adds an error when the email is not formatted correctly
  def email_format
    if correo.present? &&
       !correo.match(/\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i)
      errors.add(:fechas, 'El correo es incorrecto')
    end
  end
end
