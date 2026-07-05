class Questao < ApplicationRecord
    self.table_name = "questao"
    before_create :definir_timestamps
    before_update :atualizar_timestamp


    has_many :modelo_questaos, foreign_key: :idquestao, class_name: "ModeloQuestao"
    has_many :modelos,         through: :modelo_questaos
    has_many :respostas,       foreign_key: :idquestao, class_name: "Respostum"

    private

    def definir_timestamps
        self.criado_em     = Time.now
        self.atualizado_em = Time.now
    end

    def atualizar_timestamp
        self.atualizado_em = Time.now
    end
end
