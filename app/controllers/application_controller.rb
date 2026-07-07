class ApplicationController < ActionController::Base
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  before_action :require_login

  private

  def require_login
    unless session[:usuario_id]
      redirect_to login_path, alert: "Faça login para continuar."
    end
  end

  def current_usuario
    @current_usuario ||= Usuario.find_by(id: session[:usuario_id])
  end
  helper_method :current_usuario

  def current_tipo
    return @current_tipo if defined?(@current_tipo)
    @current_tipo = if Admin.exists?(idusuario: session[:usuario_id])
      :admin
    elsif Professor.exists?(idusuario: session[:usuario_id])
      :professor
    elsif Aluno.exists?(idusuario: session[:usuario_id])
      :aluno
    end
  end
  helper_method :current_tipo

  def current_aluno
    @current_aluno ||= Aluno.find_by(idusuario: session[:usuario_id])
  end
  helper_method :current_aluno

  def require_admin_ou_professor
    unless [:admin, :professor].include?(current_tipo)
      redirect_to root_path, alert: "Acesso não permitido."
    end
  end

  def current_professor
    @current_professor ||= Professor.find_by(idusuario: session[:usuario_id])
  end
  helper_method :current_professor

  def require_admin
    unless current_tipo == :admin
      redirect_to root_path, alert: "Acesso negado. Apenas administradores podem acessar esta página."
    end
  end
end
