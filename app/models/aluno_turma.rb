class AlunoTurma < ApplicationRecord
    self.table_name = "aluno_turma"
    self.primary_key = nil

    belongs_to :aluno, foreign_key: :idaluno, class_name: "Aluno"
    belongs_to :turma, foreign_key: :idturma, class_name: "Turma"
end