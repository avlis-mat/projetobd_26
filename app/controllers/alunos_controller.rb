class AlunosController < ApplicationController
  before_action :set_aluno, only: %i[ show edit update destroy ]

  # GET /alunos or /alunos.json
  def index
    @alunos = Aluno.includes(:usuario).all
  end

  # GET /alunos/1 or /alunos/1.json
  def show
  end

  # GET /alunos/new
  def new
    @aluno = Aluno.new
    @usuario - Usuario.new
  end

  # GET /alunos/1/edit
  def edit
    @usuario = @aluno.usuario
  end


  def create
    ActiveRecord::Base.transaction do
      @usuario = Usuario.new(usuario_params)
      @usuario.save!

      @aluno = Aluno.new(aluno_params)
      @aluno.idusuario = @usuario.id
      @aluno.save!
    end

    redirect_to alunos_path, notice: "Aluno criado com sucesso!"
    rescue ActiveRecord::RecordInvalid => e
    @usuario ||= Usuario.new
    flash.now[:alert] = "Erro ao criar aluno: #{e.message}"
    render :new, status: :unprocessable_entity
  end

  # PATCH/PUT /alunos/1 or /alunos/1.json
  def update
    ActiveRecord::Base.transaction do
      @aluno.usuario.update!(usuario_params)
      @aluno.update!(aluno_params)
    end

    redirect_to alunos_path, notice: "Aluno atualizado com sucesso!"
    rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = "Erro ao atualizar: #{e.message}"
    render :edit, status: :unprocessable_entity
  end


  def destroy
    ActiveRecord::Base.transaction do
      usuario = @aluno.usuario
      @aluno.destroy!
      usuario.destroy!
    end

    redirect_to alunos_path, notice: "Aluno removido com sucesso!"
  end

  private
    
  def set_aluno
    @aluno = Aluno.find(params[:id])
  end

  def usuario_params
    params.require(:usuario).permit(:nome, :email, :senha, :status, :iddepartamento)
  end

  def aluno_params
    params.require(:aluno).permit(:matricula, :tipo_graduacao, :semestre)
  end

end
