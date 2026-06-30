class Questao < ApplicationRecord
    self.table_name = "questao"

    has_many :modelo_questaos, foreign_key: :idquestao, class_name: "ModeloQuestao"
    has_many :modelos,         through: :modelo_questaos
    has_many :respostas,       foreign_key: :idquestao, class_name: "Respostum"
end
