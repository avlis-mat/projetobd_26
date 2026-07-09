class UsuariosController < ApplicationController
  before_action :set_usuario, only: %i[ show edit update destroy ]
  before_action :require_admin, only: %i[ new create destroy ]

  # GET /usuarios or /usuarios.json
  def index
    @usuarios = Usuario.includes(:departamento, :aluno, :professor, :admin).all
  end

  # GET /usuarios/1 or /usuarios/1.json
  def show
  end

  # GET /usuarios/new
  def new
    @usuario = Usuario.new
    @departamentos = Departamento.all
  end

  # GET /usuarios/1/edit
  def edit
    @departamentos = Departamento.all
  end

  # POST /usuarios or /usuarios.json
  def create
    ActiveRecord::Base.transaction do
      @usuario = Usuario.new(usuario_params)
      @usuario.save!

      case params[:tipo_usuario]
        when "aluno"
          Aluno.create!(
            idusuario:      @usuario.id,
            matricula:      params[:matricula],
            tipo_graduacao: params[:tipo_graduacao],
            semestre:       params[:semestre]
          )
        when "professor"
          Professor.create!(
            idusuario:       @usuario.id,
            dt_contratacao:  params[:dt_contratacao]
          )
        when "admin"
          Admin.create!(
            idusuario:  @usuario.id,
            nv_acesso:  params[:nv_acesso]
          )
      end
    end

  redirect_to usuarios_path, notice: "Usuário criado com sucesso!"
rescue ActiveRecord::RecordInvalid => e
  @departamentos = Departamento.all
  flash.now[:alert] = "Erro: #{e.message}"
  render :new, status: :unprocessable_entity
  end

  # PATCH/PUT /usuarios/1 or /usuarios/1.json
  def update
    respond_to do |format|
      if @usuario.update(usuario_params)
        format.html { redirect_to @usuario, notice: "Usuario atualizado com sucesso!", status: :see_other }
        format.json { render :show, status: :ok, location: @usuario }
      else
        format.html { 
          @departamentos = Departamento.all  
          render :edit, status: :unprocessable_content }
        format.json { render json: @usuario.errors, status: :unprocessable_content }
      end
    end
  end

  # DELETE /usuarios/1 or /usuarios/1.json
  def destroy
    if @usuario.destroy
      respond_to do |format|
        format.html { redirect_to usuarios_path, notice: "Usuario removido com sucesso!", status: :see_other }
        format.json { head :no_content }
      end
    else
      respond_to do |format|
        format.html { redirect_to usuarios_path, alert: @usuario.errors.full_messages.to_sentence, status: :see_other }
        format.json { render json: @usuario.errors, status: :unprocessable_content }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_usuario
      @usuario = Usuario.find(params.expect(:id))
    end

    # Only allow a list of trusted parameters through.
    def usuario_params
      params.expect(usuario: [ :nome, :email, :senha, :status, :iddepartamento ])
    end
end
