class UsersController < ApplicationController
  before_action :set_event, only: [:crud, :index]
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :isnt_admin, only: [:crud, :spreadsheet]
  before_action :is_current_user, only: [:update, :destroy, :edit]
  
  def is_current_user
    if current_user.id != params[:id] && current_user.adm == false
      redirect_to user_path(User.find(params[:id]))
    end 
  end
  
  def crud
    @users = if params[:term]
      if Ej.find_by(name: params[:term])
        User.where("name LIKE (?) OR last_name LIKE (?) OR email LIKE (?) OR cpf LIKE (?) OR ej_id LIKE (?)",
        "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{Ej.find_by(name: params[:term]).id}%").paginate(page: params[:page], per_page: 10)
      else
        User.where("name LIKE (?) OR last_name LIKE (?) OR email LIKE (?) OR cpf LIKE (?)",
        "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%", "%#{params[:term]}%").paginate(page: params[:page], per_page: 10)
      end
    else
      User.paginate(page: params[:page], per_page: 6)
    end
  end
  
  def index
    @users = if params[:term]
      if Ej.find_by(name: params[:term])
        User.where("name LIKE (?) OR last_name LIKE (?) OR ej_id LIKE (?)",
        "%#{params[:term]}%", "%#{params[:term]}%", "%#{Ej.find_by(name: params[:term]).id}%").paginate(page: params[:page], per_page: 12)
      else
        User.where("name LIKE (?) OR last_name LIKE (?)",
        "%#{params[:term]}%", "%#{params[:term]}%").paginate(page: params[:page], per_page: 12)
      end
    else
      User.paginate(page: params[:page], per_page: 12)
    end
  end
  
  def spreadsheet
    @users = if params[:term]
      render xlsx: 'usuarios', template: 'my/template', filename: "my_products.xlsx", disposition: 'inline', xlsx_author: "IN Junior" 
    end
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @event = Event.first
    @lecture = Lecture.find_by(params[:id])
    @workshop = Workshop.find_by(params[:id])
    @lec_user = LecUser.where(user_id: current_user.id)
    @work_user = WorkUser.where(user_id: current_user.id)
  end

  # GET /users/new
  def new
    @user = User.new
    @ejs = Ej.all
  end

  def signup
    @user = User.new
    @ejs = Ej.all
  end
  
  # GET /users/1/edit
  def edit
    @ejs = Ej.all
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
      if @user.save
        UserMailer.registration_confirmation(@user).deliver
        
        if @user.ej_id
          ej = Ej.find(@user.ej_id)
          ej.members = ej.members + 1
          ej.save
      
          federation = Federation.find(ej.federation_id)
          federation.members = federation.members + 1
          federation.save
        end
        
        flash[:success] = "Por favor, confime seu email para continuar"
        redirect_to login_path
      else
        flash[:error] = "Acao invalida, tente novamente"
        render :new
      end
  end
  
  def facecreate
    @user = User.new(user_params)
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if current_user == @user || current_user.adm
      previous_ej_id = @user.ej_id
      if @user.ej_id
        previous_federation_id = @user.ej.federation_id
      end
      respond_to do |format|
        if @user.update(user_params)
          if @user.ej_id != previous_ej_id
            if previous_ej_id
              previous_ej = Ej.find(previous_ej_id)
              previous_ej.members = previous_ej.members - 1
              previous_ej.save
            end
            
            if previous_federation_id
              previous_federation = Federation.find(previous_federation_id)
              previous_federation.members = previous_federation.members - 1
              previous_federation.save
            end
            if @user.ej
              new_ej = Ej.find(@user.ej_id)
              new_ej.members = new_ej.members + 1
              new_ej.save
            end
            if @user.ej.federation_id
              new_federation = Federation.find(@user.ej.federation_id)
              new_federation.members = new_federation.members + 1
              new_federation.save
            end
          end 
          
          format.html { redirect_to @user, notice: 'Perfil atualizado com sucesso.' }
          format.json { render :show, status: :ok, location: @user }
        else
          format.html { render :edit }
          format.json { render json: @user.errors, status: :unprocessable_entity }
        end
      end
    end
  end
  
  def update_payment
    @users = User.all
    @user = User.find(params[:id])
    if @user.payment_status?
      @user.payment_status = false
      @user.save
      respond_to do |format|
        format.html { redirect_to users_crud_path, notice: 'Pagamento atualizado com sucesso' }
        format.js
      end
    else
      @user.payment_status = true
      @user.save
      respond_to do |format|
        format.html { redirect_to users_crud_path, notice: 'Pagamento ativo com sucesso' }
        format.js
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    if current_user != @user || current_user.adm == false
      if @user.adm
        respond_to do |format|
          format.html { redirect_to users_url, notice: 'Um administrador não pode ser destruído.' }
          format.json { head :no_content }
        end
      else
        @user.destroy
        if @user.ej_id
          ej = Ej.find(@user.ej_id)
          ej.members = ej.members - 1
          ej.save
          
          federation = Federation.find(ej.federation_id)
          federation.memberss = federation.members - 1
          federation.save
        end
      end
      
      respond_to do |format|
        format.html { redirect_to users_crud_path, notice: 'Usuario removido com sucesso.' }
        format.json { head :no_content }
      end
    end
  end
  
  def confirm_email
    user = User.find_by_confirm_token(params[:id])
    if user
      user.email_activate
      flash[:success] = "Bem vindo ao EventIN! Seu email foi conrfimado.
      Faca login para continuar."
      redirect_to login_path
    else
      flash[:error] = "Desculpe, usuario nao existe"
      redirect_to login_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end
    
    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :last_name, :email, :password, :password_confirmation, :cpf, 
      :birth, :gender, :payment_type, :payment_status, :ej_id, :federation_id, :room_id, :photo, :provider, :uid, 
      :oauth_token, :oauth_expires_at, :email_confirmed, :confirm_token, :term, :adm, :job)
    end
end
