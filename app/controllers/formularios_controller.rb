class FormulariosController < ApplicationController
  before_action :set_formulario, only: %i[ show edit update destroy responder enviar_respostas ]
  before_action :require_admin_ou_professor, only: %i[new create edit update destroy]

  
  def index
    @formularios = if current_tipo == :aluno
      # Só formulários das turmas do aluno
      Formulario.includes(:usuario, :turma, :modelo)
                .where(idturma: current_aluno.turmas.pluck(:id))
    else
      Formulario.includes(:usuario, :turma, :modelo).all
    end
  end

  
  def show
    if current_tipo == :aluno
      unless current_aluno.turmas.pluck(:id).include?(@formulario.idturma)
        redirect_to formularios_path, alert: "Você não tem acesso a este formulário."
        return
      end
    end
  end

  
  def new
    @formulario = Formulario.new
    @usuarios = Usuario.all
    @turmas = Turma.all
    @modelos = Modelo.all
  end

  
  def edit
    @usuarios = Usuario.all
    @turmas = Turma.all
    @modelos = Modelo.all
  end

  
  def create
    @formulario = Formulario.new(formulario_params)
    # @formulario.arquivo.attach(params[:formulario][:arquivo]) if params[:formulario][:arquivo].present?

    if @formulario.save
      redirect_to formularios_path, notice: "Formulário criado com sucesso!"
    else
      @usuarios = Usuario.all
      @turmas = Turma.all
      @modelos = Modelo.all
      render :new, status: :unprocessable_entity
    end
  end

  
  def update
    # @formulario.arquivo.attach(params[:formulario][:arquivo]) if params[:formulario][:arquivo].present?

    if @formulario.update(formulario_params)
      redirect_to formularios_path, notice: "Formulário atualizado com sucesso!"
    else
      @usuarios = Usuario.all
      @turmas = Turma.all
      @modelos = Modelo.all
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /formularios/1 or /formularios/1.json
  def destroy
    if @formulario.destroy
      respond_to do |format|
        format.html { redirect_to formularios_path, notice: "Formulário removido com sucesso!", status: :see_other }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to formularios_path, alert: @formulario.errors.full_messages.to_sentence, status: :see_other }
        format.json { render json: @formulario.errors, status: :unprocessable_content }
      end
    end
  end

  # actions para responder formulário

  def responder
  # Verifica se o aluno tem acesso ao formulário
  if current_tipo == :aluno
    unless current_aluno.turmas.pluck(:id).include?(@formulario.idturma)
      redirect_to formularios_path, alert: "Você não tem acesso a este formulário."
      return
    end

    if @formulario.status != "aberto"
      redirect_to formularios_path, alert: "Este formulário não está mais disponível."
      return
    end
  end

  # Carrega as questões do modelo vinculado ao formulário
  @questoes = @formulario.modelo.questaos

  # Verifica quais questões o aluno já respondeu neste formulário
  if current_tipo == :aluno
    @ja_respondidas = Respostum.where(
      idaluno:      current_aluno.idusuario,
      idformulario: @formulario.id
    ).pluck(:idquestao)
  else
    @ja_respondidas = []
  end
end

def enviar_respostas
  if current_tipo != :aluno
    redirect_to formularios_path, alert: "Apenas alunos podem responder formulários."
    return
  end

  respostas = params[:respostas] || {}

  if respostas.empty?
    redirect_to responder_formulario_path(@formulario),
      alert: "Responda pelo menos uma questão."
    return
  end

  ActiveRecord::Base.transaction do
    respostas.each do |questao_id, conteudo|
      next if conteudo.blank?

      # Evita duplicata — atualiza se já existe
      resposta = Respostum.find_or_initialize_by(
        idaluno:      current_aluno.idusuario,
        idformulario: @formulario.id,
        idquestao:    questao_id.to_i
      )
      resposta.conteudo = conteudo
      resposta.save!
    end
  end

  redirect_to minhas_respostas_resposta_path,
    notice: "Respostas enviadas com sucesso!"
rescue ActiveRecord::RecordInvalid => e
  redirect_to responder_formulario_path(@formulario),
    alert: "Erro ao salvar: #{e.message}"
end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_formulario
      @formulario = Formulario.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def formulario_params
      params.require(:formulario).permit(:titulo, :status, :data_inicio, :data_fim,
                                        :criado_em, :instrucoes, :destinatario,
                                        :idusuario, :idturma, :idmodelo, 
                                        :arquivo)
    end
end
