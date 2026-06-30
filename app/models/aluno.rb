class Aluno < ApplicationRecord
    self.table_name = "aluno"
    self.primary_key = "idusuario"

    belongs_to :usuario, foreign_key: "idUsuario", class_name: "Usuario"
    has_many :aluno_turmas, foreign_key: "idAluno", class_name: "AlunoTurma"
    has_many :turmas, through: :aluno_turmas
    has_many :respostas, foreign_key: "idAluno", class_name: "Resposta"
end
