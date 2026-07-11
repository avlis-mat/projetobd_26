class Aluno < ApplicationRecord
    self.table_name = "aluno"
    self.primary_key = "idusuario"

    belongs_to :usuario, foreign_key: "idusuario", class_name: "Usuario"
    has_many :aluno_turmas, foreign_key: "idaluno", class_name: "AlunoTurma"
    has_many :turmas, through: :aluno_turmas
    has_many :respostas, foreign_key: "idaluno", class_name: "Resposta"

    before_destroy :verificar_dependentes

    private

    def verificar_dependentes
        if AlunoTurma.exists?(idaluno: idusuario)
            errors.add(:base, "Não é possível excluir um aluno que está vinculado a turmas.")
            throw :abort
        end

        if Respostum.exists?(idaluno: idusuario)
            errors.add(:base, "Não é possível excluir um aluno que possui respostas enviadas.")
            throw :abort
        end
    end
end
