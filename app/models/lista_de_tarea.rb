class ListaDeTarea < ApplicationRecord
  validates_presence_of :titulo, :fecha_de_inicio, :fecha_de_fin
  validate :fin_despues_inicio
  private
  def fin_despues_inicio
    if fecha_de_fin < fecha_de_inicio
      errors.add(:fecha_de_fin,
                 'La fecha de fin debe ser despues la fecha de inicio')
    end
  end
end
