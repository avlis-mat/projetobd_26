class Turma < ApplicationRecord
    self.table_name = "turma"

    belongs_to :materia,        foreign_key: :idmateria, class_name: "Materium"
    has_many :aluno_turmas,     foreign_key: :idturma,   class_name: "AlunoTurma"
    has_many :alunos,           through: :aluno_turmas
    has_many :professor_turmas, foreign_key: :idturma,   class_name: "ProfessorTurma"
    has_many :professores,      through: :professor_turmas
    has_many :admin_turmas,     foreign_key: :idturma,   class_name: "AdminTurma"
    has_many :admins,           through: :admin_turmas
    has_many :formularios,      foreign_key: :idturma,   class_name: "Formulario"
end
