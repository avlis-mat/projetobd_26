class AddIdusuarioToQuestao < ActiveRecord::Migration[8.0]
  def change
    add_column :questao, :idusuario, :integer
    add_foreign_key :questao, :usuario, column: :idusuario
  end
end
