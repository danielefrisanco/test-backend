class AddCorreoToListaDeTarea < ActiveRecord::Migration[6.0]
  def change
     add_column :lista_de_tareas, :correo, :string
  end
end
