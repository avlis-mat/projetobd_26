class AdminTurma < ApplicationRecord
    self.table_name = "admin_turma"
    self.primary_key = nil

    belongs_to :admin, foreign_key: :idadmin, class_name: "Admin"
    belongs_to :turma, foreign_key: :idturma, class_name: "Turma"
end