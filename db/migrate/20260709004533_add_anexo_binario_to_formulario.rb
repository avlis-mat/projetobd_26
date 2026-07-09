class AddAnexoBinarioToFormulario < ActiveRecord::Migration[8.0]
  def change
    add_column :formulario, :anexo_binario, :binary
    add_column :formulario, :anexo_binario_nome, :string
    add_column :formulario, :anexo_binario_tipo, :string
  end
end
