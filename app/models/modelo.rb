class Modelo < ApplicationRecord
    self.table_name = "modelo"

    belongs_to :usuario,        foreign_key: :idusuario, class_name: "Usuario"
    has_many :modelo_questaos,  foreign_key: :idmodelo,  class_name: "ModeloQuestao"
    has_many :questoes,         through: :modelo_questaos
    has_many :formularios,      foreign_key: :idmodelo,  class_name: "Formulario"
end
