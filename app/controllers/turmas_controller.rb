class TurmasController < ApplicationController
  before_action :set_turma, only: %i[ show edit update destroy ]

  # GET /turmas or /turmas.json
  def index
    @turmas = Turma.includes(:materia, :professors, :alunos).all
  end

  # GET /turmas/1 or /turmas/1.json
  def show
    @professors = @turma.professors.includes(:usuario)
    @alunos = @turma.alunos.includes(:usuario)
    @formularios = @turma.formularios
  end

  # GET /turmas/new
  def new
    @turma = Turma.new
    @materias = Materium.all
  end

  # GET /turmas/1/edit
  def edit
    @materias = Materium.all
  end

  # POST /turmas or /turmas.json
  def create
    @turma = Turma.new(turma_params)

    respond_to do |format|
      if @turma.save
        format.html { redirect_to @turma, notice: "Turma cirada com sucesso!" }
        format.json { render :show, status: :created, location: @turma }
      else
        format.html { 
        @materias = Materium.all  
        render :new, status: :unprocessable_content }
        format.json { render json: @turma.errors, status: :unprocessable_content }
      end
    end
  end

  # PATCH/PUT /turmas/1 or /turmas/1.json
  def update
    respond_to do |format|
      if @turma.update(turma_params)
        format.html { redirect_to @turma, notice: "Turma atualizada com sucesso!", status: :see_other }
        format.json { render :show, status: :ok, location: @turma }
      else
        format.html { 
          @materias = Materium.all  
          render :edit, status: :unprocessable_content }
        format.json { render json: @turma.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /turmas/1 or /turmas/1.json
  def destroy
    @turma.destroy!

    respond_to do |format|
      format.html { redirect_to turmas_path, notice: "Turma removida com sucesso!", status: :see_other }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_turma
      @turma = Turma.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def turma_params
      params.expect(turma: [ :turno, :horario, :codigo, :idmateria ])
    end
end
