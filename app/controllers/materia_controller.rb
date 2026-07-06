class MateriaController < ApplicationController
  before_action :set_materium, only: %i[ show edit update destroy ]
  before_action :require_admin_ou_professor, only: %i[new create edit update destroy]

  # GET /materia or /materia.json
  def index
    @materia = if current_tipo == :aluno
      # Só matérias das turmas do aluno
      Materium.joins(:turmas)
              .where(turmas: { id: current_aluno.turmas.pluck(:id) })
              .distinct
    else
      Materium.includes(:departamento).all
    end
  end

  # GET /materia/1 or /materia/1.json
  def show
  end

  # GET /materia/new
  def new
    @materium = Materium.new
    @departamentos = Departamento.all
  end

  # GET /materia/1/edit
  def edit
    @departamentos = Departamento.all
  end

  # POST /materia or /materia.json
  def create
    @materium = Materium.new(materium_params)

    if @materium.save
      redirect_to materia_path, notice: "Matéria criada com sucesso!"
    else
      @departamentos = Departamento.all
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /materia/1 or /materia/1.json
  def update
    if @materium.update(materium_params)
      redirect_to materia_path, notice: "Matéria atualizada com sucesso!"
    else
      @departamentos = Departamento.all
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /materia/1 or /materia/1.json
  def destroy
    if @materium.destroy
      respond_to do |format|
        format.html { redirect_to materia_path, notice: "Matéria removida com sucesso!", status: :see_other }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to materia_path, alert: @materium.errors.full_messages.to_sentence, status: :see_other }
        format.json { render json: @materium.errors, status: :unprocessable_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_materium
      @materium = Materium.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def materium_params
      params.require(:materium).permit(:nome, :codigo, :semestre, :iddepartamento)
    end
end
