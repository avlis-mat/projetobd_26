class Turma < ApplicationRecord
    self.table_name = "turma"

    belongs_to :materia,        foreign_key: :idmateria, class_name: "Materium"
    has_many :aluno_turmas,     foreign_key: :idturma,   class_name: "AlunoTurma"
    has_many :alunos,           through: :aluno_turmas
    has_many :professor_turmas, foreign_key: :idturma,   class_name: "ProfessorTurma"
    has_many :professors,      through: :professor_turmas
    has_many :admin_turmas,     foreign_key: :idturma,   class_name: "AdminTurma"
    has_many :admins,           through: :admin_turmas
    has_many :formularios,      foreign_key: :idturma,   class_name: "Formulario"

    before_destroy :verificar_dependentes

    private

    def verificar_dependentes
        if AlunoTurma.exists?(idturma: id)
            errors.add(:base, "Não é possível excluir uma turma que possui alunos vinculados.")
            throw :abort
        end

        if ProfessorTurma.exists?(idturma: id)
            errors.add(:base, "Não é possível excluir uma turma que possui professores vinculados.")
            throw :abort
        end

        if Formulario.exists?(idturma: id)
            errors.add(:base, "Não é possível excluir uma turma que possui formulários associados.")
            throw :abort
        end
    end

end
