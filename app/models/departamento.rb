class Departamento < ApplicationRecord
    self.table_name = "departamento"
    self.primary_key = "codigo"

    has_many :usuarios, foreign_key: :iddepartamento, class_name: "Usuario"
    has_many :materias, foreign_key: :iddepartamento, class_name: "Materium"

    before_destroy :verificar_dependentes

    private

    def verificar_dependentes
        if usuarios.exists?
            errors.add(:base, "Não é possível excluir um departamento que possui usuários associados.")
            throw :abort
        end
        if materias.exists?
            errors.add(:base, "Não é possível excluir um departamento que possui matérias associadas.")
            throw :abort
        end
    end
end
