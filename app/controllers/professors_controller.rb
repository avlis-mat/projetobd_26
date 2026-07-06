class ProfessorsController < ApplicationController
  before_action :set_professor, only: %i[ show edit update destroy ]

  
  def index
    @professors = Professor.includes(:usuario, :turmas).all
  end

  
  def show
  end

  # GET /professors/new
  def new
    @professor = Professor.new
    @usuario = Usuario.new
  end

  # GET /professors/1/edit
  def edit
    @usuario = @professor.usuario
  end

  # POST /professors or /professors.json
  def create
    ActiveRecord::Base.transaction do
      @usuario = Usuario.new(usuario_params)
      @usuario.save!

      @professor = Professor.new(professor_params)
      @professor.idusuario = @usuario.id
      @professor.save!
    end

    redirect_to professors_path, notice: "Professor criado com sucesso!"
  rescue ActiveRecord::RecordInvalid => e
    @usuario ||= Usuario.new
    flash.now[:alert] = "Erro ao criar professor: #{e.message}"
    render :new, status: :unprocessable_entity
  end

  
  def update
    ActiveRecord::Base.transaction do
      @professor.usuario.update!(usuario_params)
      @professor.update!(professor_params)
    end

    redirect_to professors_path, notice: "Professor atualizado com sucesso!"
    rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = "Erro ao atualizar: #{e.message}"
    render :edit, status: :unprocessable_entity
  end

  # DELETE /professors/1 or /professors/1.json
  def destroy
    ActiveRecord::Base.transaction do
      usuario = @professor.usuario
      @professor.destroy!
      usuario.destroy!
    end

    redirect_to professors_path, notice: "Professor removido com sucesso!"
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_professor
      @professor = Professor.find(params[:id])
    end

    def usuario_params
      params.require(:usuario).permit(:nome, :email, :senha, :status, :iddepartamento)
    end

    # Only allow a list of trusted parameters through.
    def professor_params
      params.require(:professor).permit(:dt_contratacao)
    end
end
