class Modelo < ApplicationRecord
    self.table_name = "modelo"
    before_create :definir_timestamps
    before_update :atualizar_timestamp


    belongs_to :usuario,        foreign_key: :idusuario, class_name: "Usuario"
    has_many :modelo_questaos,  foreign_key: :idmodelo,  class_name: "ModeloQuestao"
    has_many :questaos,         through: :modelo_questaos
    has_many :formularios,      foreign_key: :idmodelo,  class_name: "Formulario"

    before_destroy :verificar_formularios

    private

    def definir_timestamps
        self.criado_em    = Time.now
        self.atualizado_em = Time.now
    end

    def atualizar_timestamp
        self.atualizado_em = Time.now
    end

    def verificar_formularios
        if formularios.exists?
            errors.add(:base, "Não é possível excluir um modelo que possui formulários associados.")
            throw :abort
        end
    end
end
