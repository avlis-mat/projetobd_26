class PainelController < ApplicationController
  def index
    if current_tipo == :aluno
      # Dashboard simplificado para aluno
      redirect_to turmas_path
    else
      @vw_formularios = ActiveRecord::Base.connection.execute(
        "SELECT * FROM vw_formularios_turma ORDER BY turma_id"
      )
      @ultimas_respostas = Respostum.includes(:aluno, :questao, :formulario)
                                  .order(respondido_em: :desc)
                                  .limit(5)
      @questoes_recentes = Questao.where.not(atualizado_em: nil)
                                  .order(atualizado_em: :desc)
                                  .limit(5)
      @formularios_vencidos = Formulario.where(
        "data_fim < ? AND status != ?", Date.today, "encerrado"
      )
    end
  end

  def executar_procedure
    ActiveRecord::Base.connection.execute("CALL encerrar_formularios_vencidos()")
    redirect_to painel_index_path,
      notice: "Procedure executada! Formulários vencidos encerrados."
  end
end
