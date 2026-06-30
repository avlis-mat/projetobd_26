class Professor < ApplicationRecord
    self.table_name = "professor"
    self.primary_key = "idusuario"

    belongs_to :usuario,        foreign_key: :idusuario,   class_name: "Usuario"
    has_many :professor_turmas, foreign_key: :idprofessor, class_name: "ProfessorTurma"
    has_many :turmas,           through: :professor_turmas
    has_many :formularios,      through: :usuario
end
