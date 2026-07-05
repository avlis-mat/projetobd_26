class PainelController < ApplicationController
  def index
    # Dados da View do banco
    @vw_formularios = ActiveRecord::Base.connection.execute(
      "SELECT * FROM vw_formularios_turma ORDER BY turma_id"
    )

    # Últimas respostas — demonstra o trigger respondido_em
    @ultimas_respostas = Respostum.includes(:aluno, :questao, :formulario)
                                 .order(respondido_em: :desc)
                                 .limit(5)

    # Últimas questões editadas — demonstra o trigger atualizado_em
    @questoes_recentes = Questao.where.not(atualizado_em: nil)
                                .order(atualizado_em: :desc)
                                .limit(5)

    # Formulários abertos que podem ser encerrados pela procedure
    @formularios_vencidos = Formulario.where(
      "data_fim < ? AND status != ?", Date.today, "encerrado"
    )
  end

  def executar_procedure
    ActiveRecord::Base.connection.execute("CALL encerrar_formularios_vencidos()")
    redirect_to painel_index_path,
      notice: "Procedure executada! Formulários vencidos encerrados."
  end
end
