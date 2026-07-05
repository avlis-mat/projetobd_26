class FormulariosController < ApplicationController
  before_action :set_formulario, only: %i[ show edit update destroy ]

  
  def index
    @formularios = Formulario.includes(:usuario, :turma, :modelo).all
  end

  
  def show
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
    @formulario.destroy!

    redirect_to formularios_path, notice: "Formulário removido com sucesso!"
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
