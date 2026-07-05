class Formulario < ApplicationRecord
    self.table_name = "formulario"
    before_create :definir_criado_em

    belongs_to :usuario, foreign_key: "idusuario", class_name: "Usuario"
    belongs_to :turma, foreign_key: "idturma", class_name: "Turma"
    belongs_to :modelo, foreign_key: "idmodelo", class_name: "Modelo"

    has_many :respostas, foreign_key: "idformulario", class_name: "Respostum"
    has_one_attached :arquivo

    private

    def definir_criado_em
        self.criado_em = Time.now
    end
end
