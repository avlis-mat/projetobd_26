class Materium < ApplicationRecord
    self.table_name = "materia"

    belongs_to :departamento, foreign_key: "iddepartamento", class_name: "Departamento"
    has_many :turmas, foreign_key: "idmateria", class_name: "Turma"

    before_destroy :verificar_turmas

    private

    def verificar_turmas
        if turmas.exists?
            errors.add(:base, "Não é possível excluir uma matéria que possui turmas associadas.")
            throw :abort
        end
    end
end
