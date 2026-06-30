class Admin < ApplicationRecord
    self.table_name = "admin"
    self.primary_key = "idusuario"

    belongs_to :usuario,     foreign_key: :idusuario, class_name: "Usuario"
    has_many :admin_turmas,  foreign_key: :idadmin,   class_name: "AdminTurma"
    has_many :turmas,        through: :admin_turmas
    has_many :modelos,       through: :usuario
    has_many :formularios,   through: :usuario
end
