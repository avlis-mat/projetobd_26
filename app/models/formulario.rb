class Formulario < ApplicationRecord
    self.table_name = "formulario"

    belongs_to :usuario, foreign_key: "idUsuario", class_name: "Usuario"
    belongs_to :turma, foreign_key: "idTurma", class_name: "Turma"
    belongs_to :modelo, foreign_key: "idModelo", class_name: "Modelo"

    has_many :respostas, foreign_key: "idFormulario", class_name: "Respostum"

end
