class Departamento < ApplicationRecord
    self.table_name = "departamento"
    self.primary_key = "codigo"

    has_many :usuarios, foreign_key: :iddepartamento, class_name: "Usuario"
    has_many :materias, foreign_key: :iddepartamento, class_name: "Materium"
end
