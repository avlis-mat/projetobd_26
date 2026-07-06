class Formulario < ApplicationRecord
    self.table_name = "formulario"
    before_create :definir_criado_em

    belongs_to :usuario, foreign_key: "idusuario", class_name: "Usuario"
    belongs_to :turma, foreign_key: "idturma", class_name: "Turma"
    belongs_to :modelo, foreign_key: "idmodelo", class_name: "Modelo"

    has_many :respostas, foreign_key: "idformulario", class_name: "Respostum"
    has_one_attached :arquivo

    before_destroy :verificar_respostas

    private

    def definir_criado_em
        self.criado_em = Time.now
    end

    def verificar_respostas
        if respostas.exists?
            errors.add(:base, "Não é possível excluir o formulário, pois existem respostas associadas a ele.")
            throw(:abort)
        end
    end
end
