class SessionsController < ApplicationController
  before_action :logged_user, only: [:new, :create]
  
  def new
    @event = Event.first
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      if user.adm? || (Event.first.present? && (Event.first.begin_day < DateTime.now && DateTime.now < Event.first.end_day))
        if user.email_confirmed || user.adm?
          log_in user
          redirect_to root_path
        else
          flash.now[:error] = ' Por favor confirme sua conta seguindo 
          as instruções enviadas para seu email, para poder presseguir.'
          render 'new'
        end
      else
        flash.now[:error] = 'Evento não disponível.'
        render 'new'
      end
    else
      flash.now[:danger] = 'Combinação de email e senha inválida.'
      render 'new'
    end
  end
  
  def facecreate
    user = User.from_omniauth(request.env["omniauth.auth"])
    if Event.first.present? && (Event.first.begin_day < DateTime.now && DateTime.now < Event.first.end_day)
      log_in user
      redirect_to root_path
    else
      flash.now[:error] = 'Evento não disponível.'
      render 'new'
    end
  end
  
  def destroy
    log_out
    redirect_to login_path
    flash[:info] = "Até logo.."
  end

  private
  
  def session_params
    params.require(:session).permit(:email, :password, :email_confirmed)
  end
end
