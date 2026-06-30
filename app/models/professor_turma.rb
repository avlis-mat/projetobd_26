class ProfessorTurma < ApplicationRecord
    self.table_name = "professor_turma"
    self.primary_key = nil

    belongs_to :professor, foreign_key: :idprofessor, class_name: "Professor"
    belongs_to :turma,     foreign_key: :idturma,     class_name: "Turma"
end