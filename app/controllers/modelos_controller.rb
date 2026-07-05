class ModelosController < ApplicationController
  before_action :set_modelo, only: %i[ show edit update destroy ]

  # GET /modelos or /modelos.json
  def index
    @modelos = Modelo.includes(:usuario).all
  end

  # GET /modelos/1 or /modelos/1.json
  def show
    @questoes = @modelo.questaos
  end

  # GET /modelos/new
  def new
    @modelo = Modelo.new
    @usuarios = Usuario.all
    @questoes = Questao.all
  end

  # GET /modelos/1/edit
  def edit
    @usuarios = Usuario.all
    @questoes = Questao.all
    @questoes_selecionadas = @modelo.questaos.pluck(:id)
  end

  # POST /modelos or /modelos.json
  def create
    @modelo = Modelo.new(modelo_params)

    if @modelo.save
      # Associa questões selecionadas ao modelo
      if params[:questao_ids].present?
        params[:questao_ids].each do |questao_id|
          ModeloQuestao.create!(idmodelo: @modelo.id, idquestao: questao_id)
        end
      end
      redirect_to modelos_path, notice: "Modelo criado com sucesso!"
    else
      @usuarios = Usuario.all
      @questoes = Questao.all
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /modelos/1 or /modelos/1.json
  def update
    if @modelo.update(modelo_params)
      # Atualiza questões associadas
      if params[:questao_ids].present?
        ModeloQuestao.where(idmodelo: @modelo.id).delete_all
        params[:questao_ids].each do |questao_id|
          ModeloQuestao.create!(idmodelo: @modelo.id, idquestao: questao_id)
        end
      end
      redirect_to modelos_path, notice: "Modelo atualizado com sucesso!"
    else
      @usuarios = Usuario.all
      @questoes = Questao.all
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /modelos/1 or /modelos/1.json
  def destroy
    ActiveRecord::Base.transaction do
    # Primeiro remove as associações
    ModeloQuestao.where(idmodelo: @modelo.id).delete_all
    # Depois remove o modelo
    @modelo.destroy!
  end

  respond_to do |format|
    format.html { redirect_to modelos_path, notice: "Modelo removido com sucesso!", status: :see_other }
    format.json { head :no_content }
  end
rescue ActiveRecord::RecordNotDestroyed => e
  redirect_to modelos_path, alert: "Erro ao remover: #{e.message}"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_modelo
      @modelo = Modelo.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def modelo_params
      params.expect(modelo: [ :nome, :descricao, :versao, :status, :criado_em, :atualizado_em, :idusuario ])
    end
end
