class Usuario < ApplicationRecord
    self.table_name = "usuario"

    belongs_to :departamento, foreign_key: "iddepartamento", class_name: "Departamento"
    has_one :aluno, foreign_key: "idusuario", class_name: "Aluno"
    has_one :professor, foreign_key: "idusuario", class_name: "Professor"
    has_one :admin, foreign_key: "idusuario", class_name: "Admin"
    has_many :modelos, foreign_key: "idusuario", class_name: "Modelo"
    has_many :formularios, foreign_key: "idusuario", class_name: "Formulario"

    before_destroy :verificar_dependentes

    private

    def verificar_dependentes
        if aluno&.respostas&.exists?
            errors.add(:base, "Não é possível excluir um usuário que possui respostas associadas.")
            throw :abort
        end
        if professor&.formularios&.exists?
            errors.add(:base, "Não é possível excluir um usuário que possui formulários associados.")
            throw :abort
        end
    end
end
