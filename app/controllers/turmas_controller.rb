class TurmasController < ApplicationController
  before_action :set_turma, only: %i[ show edit update destroy gerenciar_alunos adicionar_aluno remover_aluno gerenciar_professores adicionar_professor remover_professor ]
  before_action :require_admin_ou_professor, only: %i[new create edit update destroy gerenciar_alunos adicionar_aluno remover_aluno ]
  before_action :require_admin, only: %i[ gerenciar_professores adicionar_professor remover_professor ]
  before_action :verificar_professor_da_turma, only: %i[ edit update destroy gerenciar_alunos adicionar_aluno remover_aluno ]

  # GET /turmas or /turmas.json
  def index
    @turmas = if current_tipo == :aluno
      current_aluno.turmas.includes(:materia)
    else
      Turma.includes(:materia, :professors, :alunos).all
    end
  end

  # GET /turmas/1 or /turmas/1.json
  def show
    # Aluno só pode ver turmas às quais pertence
    if current_tipo == :aluno
      unless current_aluno.turmas.include?(@turma)
        redirect_to turmas_path, alert: "Você não tem acesso a esta turma."
        return
      end
    end
    @professors = @turma.professors.includes(:usuario)
    @alunos      = @turma.alunos.includes(:usuario)
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
    if @turma.destroy
      respond_to do |format|
        format.html { redirect_to turmas_path, notice: "Turma removida com sucesso!", status: :see_other }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to turmas_path, alert: @turma.errors.full_messages.to_sentence, status: :see_other }
        format.json { render json: @turma.errors, status: :unprocessable_content }
      end
    end
  end

  def gerenciar_alunos
    if current_tipo == :professor
      unless current_professor.turmas.include?(@turma)
        redirect_to turmas_path, alert: "Você não tem acesso a esta turma."
        return
      end
    end

    @alunos_na_turma = @turma.alunos.includes(:usuario)
    @alunos_fora_da_turma = Aluno.includes(:usuario).where.not(idusuario: @alunos_na_turma.pluck(:idusuario))

  end



  def adicionar_aluno
    if current_tipo == :professor
      unless current_professor.turmas.include?(@turma)
        redirect_to turmas_path, alert: "Você não leciona nesta turma."
        return
      end
    end

    aluno = Aluno.find(params[:aluno_id])

    if AlunoTurma.exists?(idturma: @turma.id, idaluno: aluno.idusuario)
      redirect_to gerenciar_alunos_turma_path(@turma),
        alert: "Aluno já está nesta turma."
    else
      AlunoTurma.create!(idturma: @turma.id, idaluno: aluno.idusuario)
      redirect_to gerenciar_alunos_turma_path(@turma),
        notice: "#{aluno.usuario&.nome} adicionado à turma com sucesso!"
    end
  end

  def remover_aluno
    if current_tipo == :professor
      unless current_professor.turmas.include?(@turma)
        redirect_to turmas_path, alert: "Você não leciona nesta turma."
        return
      end
    end

    aluno = Aluno.find(params[:aluno_id])
    AlunoTurma.where(idturma: @turma.id, idaluno: aluno.idusuario).delete_all

    redirect_to gerenciar_alunos_turma_path(@turma),
      notice: "#{aluno.usuario&.nome} removido da turma."
  end

  def gerenciar_professores
    @professores_na_turma = @turma.professors.includes(:usuario)
    @professores_fora_da_turma     = Professor.includes(:usuario)
                                    .where.not(idusuario: @professores_na_turma.pluck(:idusuario))
  end

  def adicionar_professor
    professor = Professor.find(params[:professor_id])

    if ProfessorTurma.exists?(idturma: @turma.id, idprofessor: professor.idusuario)
      redirect_to gerenciar_professores_turma_path(@turma),
        alert: "Professor já está vinculado a esta turma."
    else
      ProfessorTurma.create!(idturma: @turma.id, idprofessor: professor.idusuario)
      redirect_to gerenciar_professores_turma_path(@turma),
        notice: "#{professor.usuario&.nome} vinculado à turma com sucesso!"
    end
  end

  def remover_professor
    professor = Professor.find(params[:professor_id])
    ProfessorTurma.where(idturma: @turma.id, idprofessor: professor.idusuario).delete_all

    redirect_to gerenciar_professores_turma_path(@turma),
      notice: "#{professor.usuario&.nome} removido da turma."
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

    def verificar_professor_da_turma
      return if current_tipo == :admin
      unless current_professor.turmas.include?(@turma)
        redirect_to turmas_path, alert: "Você não leciona nesta turma."
      end
    end
    
end
