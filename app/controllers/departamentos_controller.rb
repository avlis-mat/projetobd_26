class DepartamentosController < ApplicationController
  before_action :set_departamento, only: %i[ show edit update destroy ]

  # GET /departamentos or /departamentos.json
  def index
    @departamentos = Departamento.all
  end

  # GET /departamentos/1 or /departamentos/1.json
  def show
    @materias = @departamento.materias.includes(:turmas)
  end

  # GET /departamentos/new
  def new
    @departamento = Departamento.new
  end

  # GET /departamentos/1/edit
  def edit
  end

  # POST /departamentos or /departamentos.json
  def create
    @departamento = Departamento.new(departamento_params)

    if @departamento.save
      redirect_to departamentos_path, notice: "Departamento criado com sucesso!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /departamentos/1 or /departamentos/1.json
  def update
    if @departamento.update(departamento_params)
      redirect_to departamentos_path, notice: "Departamento atualizado com sucesso!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /departamentos/1 or /departamentos/1.json
  def destroy
    if @departamento.destroy
      respond_to do |format|
        format.html { redirect_to departamentos_path, notice: "Departamento removido com sucesso!", status: :see_other }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to departamentos_path, alert: @departamento.errors.full_messages.to_sentence, status: :see_other }
        format.json { render json: @departamento.errors, status: :unprocessable_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_departamento
      @departamento = Departamento.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def departamento_params
      params.require(:departamento).permit(:nome, :codigo)
    end
end
