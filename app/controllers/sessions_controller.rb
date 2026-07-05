class SessionsController < ApplicationController
  skip_before_action :require_login

  def new
  end

  def create
    usuario = Usuario.find_by(email: params[:email])

    if usuario && usuario.senha == params[:senha]
      session[:usuario_id] = usuario.id
      redirect_to root_path, notice: "Bem-vindo, #{usuario.nome}!"
    else
      flash.now[:alert] = "Email ou senha incorretos."
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session[:usuario_id] = nil
    redirect_to login_path, notice: "Logout realizado com sucesso."
  end
end