class EjsController < ApplicationController
  before_action :non_logged_user
  before_action :set_event
  before_action :set_ej, only: [:show, :edit, :update, :destroy]
  before_action :isnt_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :first_login
  # GET /ejs
  # GET /ejs.json
  def index
    @ejs = if params[:term]
      Ej.where('name LIKE (?) OR college LIKE (?)', "%#{params[:term]}%", "%#{params[:term]}%").paginate(page: params[:page], per_page: 12)
    else
      Ej.paginate(page: params[:page], per_page: 12)
    end
  end

  # GET /ejs/1
  # GET /ejs/1.json
  def show
    @user = User.find_by(params[:id])
  end
  
  def ranking
    @ejs = Ej.all
  end

  # GET /ejs/new
  def new
    @ej = Ej.new
    @federations = Federation.all
  end

  # GET /ejs/1/edit
  def edit
    @federations = Federation.all
  end

  # POST /ejs
  # POST /ejs.json
  def create
    @ej = Ej.new(ej_params)

    respond_to do |format|
      if @ej.save
        format.html { redirect_to @ej, notice: 'Empresa Junior registrada com sucesso.' }
        format.json { render :show, status: :created, location: @ej }
      else
        format.html { render :new }
        format.json { render json: @ej.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /ejs/1
  # PATCH/PUT /ejs/1.json
  def update
    respond_to do |format|
      if @ej.update(ej_params)
        format.html { redirect_to @ej, notice: 'Empresa Junior atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @ej }
      else
        format.html { render :edit }
        format.json { render json: @ej.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /ejs/1
  # DELETE /ejs/1.json
  def destroy
    @ej.destroy
    respond_to do |format|
      format.html { redirect_to ejs_url, notice: 'Empresa Junior removida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ej
      @ej = Ej.find(params[:id])
      @users = User.where(event_id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def ej_params
      params.require(:ej).permit(:name, :college, :federation_id, :icon, :user, :federated, :term)
    end
end
