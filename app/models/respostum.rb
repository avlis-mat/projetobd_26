class Respostum < ApplicationRecord
    self.table_name = "resposta"

    belongs_to :aluno,      foreign_key: :idaluno,      class_name: "Aluno"
    belongs_to :formulario, foreign_key: :idformulario, class_name: "Formulario"
    belongs_to :questao,    foreign_key: :idquestao,    class_name: "Questao"
end
