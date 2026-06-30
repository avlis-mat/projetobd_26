class ModeloQuestao < ApplicationRecord
    self.table_name = "modelo_questao"
    self.primary_key = nil

    belongs_to :modelo,  foreign_key: :idmodelo,  class_name: "Modelo"
    belongs_to :questao, foreign_key: :idquestao, class_name: "Questao"
end