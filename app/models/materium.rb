class Materium < ApplicationRecord
    self.table_name = "materia"

    belongs_to :departamento, foreign_key: "iddepartamento", class_name: "Departamento"
    has_many :turmas, foreign_key: "idmateria", class_name: "Turma"
end
