class RespostaController < ApplicationController
  before_action :set_respostum, only: %i[ show edit update destroy ]
  before_action :require_admin_ou_professor, only: %i[edit update destroy]

  # GET /resposta or /resposta.json
  def index
    @resposta = if current_tipo == :aluno
      Respostum.includes(:aluno, :formulario, :questao)
              .where(idaluno: current_aluno.idusuario)
    else
      Respostum.includes(:aluno, :formulario, :questao).all
    end
  end

  # GET /resposta/1 or /resposta/1.json
  def show
    if current_tipo == :aluno
      unless @respostum.idaluno == current_aluno.idusuario
        redirect_to resposta_path, alert: "Você não tem acesso a esta resposta."
        return
      end
    end
  end

  # GET /resposta/new
  def new
    @respostum = Respostum.new
    if current_tipo == :aluno
      # Só mostra formulários das turmas do aluno
      @formularios = Formulario.where(
        idturma: current_aluno.turmas.pluck(:id),
        status: "aberto"
      )
      @alunos = [current_aluno]
    else
      @formularios = Formulario.all
      @alunos = Aluno.includes(:usuario).all
    end
    @questaos = Questao.all
  end

  # GET /resposta/1/edit
  def edit
    @alunos = Aluno.includes(:usuario).all
    @formularios = Formulario.all
    @questaos = Questao.all
  end

  # POST /resposta or /resposta.json
  def create
    @respostum = Respostum.new(resposta_params)

    # Força o aluno logado como autor da resposta
    if current_tipo == :aluno
      @respostum.idaluno = current_aluno.idusuario
    end

    respond_to do |format|
      if @respostum.save
        format.html { redirect_to resposta_path, notice: "Resposta enviada com sucesso!" }
        format.json { render :show, status: :created }
      else
        format.html { render :new, status: :unprocessable_content }
        format.json { render json: @respostum.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /resposta/1 or /resposta/1.json
  def update
    if @respostum.update(respostum_params)
      redirect_to resposta_path, notice: "Resposta atualizada com sucesso!"
    else
      @alunos = Aluno.includes(:usuario).all
      @formularios = Formulario.all
      @questaos = Questao.all
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /resposta/1 or /resposta/1.json
  def destroy
    @respostum.destroy!

    respond_to do |format|
      format.html { redirect_to resposta_path, notice: "Respostum removida com sucesso!", status: :see_other }
      format.json { head :no_content }
    end
  end

  def minhas_respostas
    unless current_tipo == :aluno
      redirect_to resposta_path
      return
    end

    # Agrupa respostas do aluno por formulário
    @respostas_por_formulario = Respostum
    .includes(:formulario => [:turma => :materia], :questao => [])
    .where(idaluno: current_aluno.idusuario)
    .order(:idformulario)
    .group_by(&:formulario)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_respostum
      @respostum = Respostum.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def respostum_params
      params.expect(respostum: [ :conteudo, :respondido_em, :idaluno, :idformulario, :idquestao ])
    end
end
