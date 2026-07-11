class AdminsController < ApplicationController
  before_action :set_admin, only: %i[ show edit update destroy ]

  
  def index
    @admins = Admin.includes(:usuario).all
  end

  
  def show
  end

  # GET /admins/new
  def new
    @admin = Admin.new
    @usuario = Usuario.new
  end

  # GET /admins/1/edit
  def edit
    @usuario = @admin.usuario
  end

  
  def create
    ActiveRecord::Base.transaction do
      @usuario = Usuario.new(usuario_params)
      @usuario.save!

      @admin = Admin.new(admin_params)
      @admin.idusuario = @usuario.id
      @admin.save!
    end

    redirect_to admins_path, notice: "Admin criado com sucesso!"
    rescue ActiveRecord::RecordInvalid => e
    @usuario ||= Usuario.new
    flash.now[:alert] = "Erro ao criar admin: #{e.message}"
    render :new, status: :unprocessable_entity
  end

  
  def update
    ActiveRecord::Base.transaction do
      @admin.usuario.update!(usuario_params)
      @admin.update!(admin_params)
    end

    redirect_to admins_path, notice: "Admin atualizado com sucesso!"
    rescue ActiveRecord::RecordInvalid => e
    flash.now[:alert] = "Erro ao atualizar: #{e.message}"
    render :edit, status: :unprocessable_entity
  end

  
  def destroy
    ActiveRecord::Base.transaction do
      usuario = @admin.usuario  # ajuste para cada controller
      if @admin.destroy
        usuario.destroy!
      else
        raise ActiveRecord::Rollback
      end
    end

    if @admin.errors.any?
      redirect_to admins_path,
        alert: @admin.errors.full_messages.to_sentence,
        status: :see_other
    else
      redirect_to admins_path,
        notice: "Admin removido com sucesso!",
        status: :see_other
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_admin
      @admin = Admin.find(params[:id])
    end

    def usuario_params
      params.require(:usuario).permit(:nome, :email, :senha, :status, :iddepartamento)
    end

    # Only allow a list of trusted parameters through.
    def admin_params
      params.require(:admin).permit(:nv_acesso)
    end
end
