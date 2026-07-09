class Usuario < ApplicationRecord
    self.table_name = "usuario"

    belongs_to :departamento, foreign_key: "iddepartamento", class_name: "Departamento"
    has_one :aluno, foreign_key: "idusuario", class_name: "Aluno"
    has_one :professor, foreign_key: "idusuario", class_name: "Professor"
    has_one :admin, foreign_key: "idusuario", class_name: "Admin"
    has_many :modelos, foreign_key: "idusuario", class_name: "Modelo"
    has_many :formularios, foreign_key: "idusuario", class_name: "Formulario"

    before_destroy :verificar_dependentes

    def verificar_dependentes
        if aluno.present?
            if AlunoTurma.exists?(idaluno: aluno.idusuario)
            errors.add(:base, "Aluno está vinculado a turmas.")
            end
            if Respostum.exists?(idaluno: aluno.idusuario)
            errors.add(:base, "Aluno possui respostas enviadas.")
            end
        end

        if professor.present?
            if ProfessorTurma.exists?(idprofessor: professor.idusuario)
            errors.add(:base, "Professor está vinculado a turmas.")
            end
            if Formulario.exists?(idusuario: id)
            errors.add(:base, "Professor possui formulários criados.")
            end
            if Modelo.exists?(idusuario: id)
            errors.add(:base, "Professor possui modelos criados.")
            end
            if Questao.exists?(idusuario: id)
            errors.add(:base, "Professor possui questões criadas.")
            end
        end

        throw :abort if errors.any?
    end
end
