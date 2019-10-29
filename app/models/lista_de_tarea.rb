# Wrong name, Tarea would be the correct name
class ListaDeTarea < ApplicationRecord
  validates_presence_of :titulo, :fecha_de_inicio, :fecha_de_fin
  validate :fin_despues_inicio
  validate :unique_range_of_fechas

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
      if tarea != self  && !(tarea.fecha_de_fin < fecha_de_inicio ||
                             tarea.fecha_de_inicio > fecha_de_fin)
        errors.add(:fechas,
                   'Una otra tarea es solapadas en el tiempo')
        break
      end
    end
  end
end
