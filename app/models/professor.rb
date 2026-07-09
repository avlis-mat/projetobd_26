class Professor < ApplicationRecord
    self.table_name = "professor"
    self.primary_key = "idusuario"

    belongs_to :usuario,        foreign_key: :idusuario,   class_name: "Usuario"
    has_many :professor_turmas, foreign_key: :idprofessor, class_name: "ProfessorTurma"
    has_many :turmas,           through: :professor_turmas
    has_many :formularios,      through: :usuario

    before_destroy :verificar_dependentes

    private

    def verificar_dependentes
        if ProfessorTurma.exists?(idprofessor: idusuario)
            errors.add(:base, "Não é possível excluir um professor que está vinculado a turmas.")
            throw :abort
        end

        if Formulario.exists?(idusuario: idusuario)
            errors.add(:base, "Não é possível excluir um professor que possui formulários criados.")
            throw :abort
        end

        if Modelo.exists?(idusuario: idusuario)
            errors.add(:base, "Não é possível excluir um professor que possui modelos criados.")
            throw :abort
        end

        if Questao.exists?(idusuario: idusuario)
            errors.add(:base, "Não é possível excluir um professor que possui questões criadas.")
            throw :abort
        end
    end
end
