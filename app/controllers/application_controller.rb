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
    return :admin     if Admin.exists?(idusuario: session[:usuario_id])
    return :professor if Professor.exists?(idusuario: session[:usuario_id])
    return :aluno     if Aluno.exists?(idusuario: session[:usuario_id])
    nil
  end
  helper_method :current_tipo

  def require_admin
    unless current_tipo == :admin
      redirect_to root_path, alert: "Acesso negado. Apenas administradores podem acessar esta página."
    end
  end
end
