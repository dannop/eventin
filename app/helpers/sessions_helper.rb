module SessionsHelper
  # Faz login e cria uma sessao
  def log_in(user)
    session[:user_id] = user.id
  end
  
  # Verifica se existe alguem logado
  def logged_in?
    !current_user.nil?
  end
  
  # Pagina pra mostrar se o login nao estiver disponivel
  def block_blocker
    event = Event.first
    if event.begin_day > DateTime.now || event.end_day < DateTime.now
      redirect_to blocker_path
    end
  end
  
  # Define um usuario atual
  def current_user
    @current_user ||= User.find_by(id: session[:user_id]) if session[:user_id]
  end
  
  # Define o primeiro login do site pra terminar as configurações do Evento
  def set_event
    if Event.first == nil
      redirect_to new_event_path
    else
      @event = Event.first    
    end
  end
  
  # Faz logout e deleta e sessao atual
  def log_out
    session.delete(:user_id)
    @current_user = nil
  end
  
  # Verifica se existe alguem logado
  def non_logged_user
    respond_to do |format|
      format.html { redirect_to login_path}
      flash[:info] = "Por favor, faça o login."
    end if ! logged_in?
  end
  
  # Verifica se o usuario especifico ja esta logado
  def logged_user
    respond_to do |format|
      format.html { redirect_to current_user, notice: "Já está logado!" }
    end if logged_in?
  end
  
  # Verifica se o usuario atual é o mesmo consultado e adm 
  def is_admin
    if current_user.id != @user.id && !current_user.adm
      redirect_to user_path(current_user)
      flash[:info] = "Voce nao tem permissao para isso!"
    end
  end
  
  #Função parecida com a de cima, porem só verifica se é adm
  def isnt_admin
    if !current_user.adm?
      respond_to do |format|
        format.html { redirect_to current_user, notice: "Ação inválida!" }
      end
    end
  end
  
  # Verificar o cadastro completo 
  def first_login
    if  !current_user.adm? && (!current_user.last_name.present? || !current_user.email.present? || 
        !current_user.job.present? || !current_user.cpf.present? || current_user.email == (0...6).map { ('a'..'z').to_a[rand(26)] }.join+"@facebook.com")  
      redirect_to edit_user_path(current_user)
      flash[:info] = "Complete seu cadastro!"
      
      if !current_user.last_name.present?
        flash[:info] = "Sobrenome não registrado."
      end
      
      if !current_user.email.present?
        flash[:info] = "Email não registrado."
      end
      
      if !current_user.job.present?
        flash[:info] = "Trabalho não registrado."
      end
      
      if !current_user.cpf.present?
        flash[:info] = "CPF não registrado."
      end
      
      if current_user.email == (0...6).map { ('a'..'z').to_a[rand(26)] }.join+"@facebook.com"
        flash[:info] = "Registre o seu email."
      end
    end
  end
  
  #Verifica se palestras esta disponivel 
  def lecture_period
    @event = Event.first
    if (@event.activity_begin_day < DateTime.now && DateTime.now < @event.activity_end_day) || !current_user.adm?
      redirect_to lectures_path
      flash[:info] = "Palestra nao disponivel!"
    end
  end
  
  #Verifica se workshops esta dipsonivel
  def workshop_period
    @event = Event.first
    if (@event.activity_begin_day < DateTime.now && DateTime.now < @event.activity_end_day) || !current_user.adm?
      redirect_to workshops_path
      flash[:info] = "Workshop nao disponivel!"
    end
  end

end