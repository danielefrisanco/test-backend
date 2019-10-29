class CreateListaDeTareas < ActiveRecord::Migration[6.0]
  def change
    create_table :lista_de_tareas do |t|
      t.string :titulo
      t.datetime :fecha_de_inicio
      t.datetime :fecha_de_fin

      t.timestamps
    end
  end
end
