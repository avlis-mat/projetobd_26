class RespostaController < ApplicationController
  before_action :set_respostum, only: %i[ show edit update destroy ]

  # GET /resposta or /resposta.json
  def index
    @resposta = Respostum.includes(:aluno, :formulario, :questao).all
  end

  # GET /resposta/1 or /resposta/1.json
  def show
  end

  # GET /resposta/new
  def new
    @respostum = Respostum.new
    @alunos = Aluno.includes(:usuario).all
    @formularios = Formulario.all
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
    @respostum = Respostum.new(respostum_params)

    if @respostum.save
      redirect_to resposta_path, notice: "Resposta registrada com sucesso!"
    else
      @alunos = Aluno.includes(:usuario).all
      @formularios = Formulario.all
      @questaos = Questao.all
      render :new, status: :unprocessable_entity
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
