class Materium < ApplicationRecord
    self.table_name = "materia"

    belongs_to :departamento, foreign_key: "idDepartamento", class_name: "Departamento"
    has_many :turmas, foreign_key: "idMateria", class_name: "Turma"
end
