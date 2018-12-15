class FederationsController < ApplicationController
  before_action :non_logged_user
  before_action :set_event
  before_action :isnt_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_federation, only: [:show, :edit, :update, :destroy]
  before_action :first_login
  
  # GET /federations
  # GET /federations.json
  def index
    @federations = if params[:term]
        Federation.where("name LIKE (?) OR state LIKE (?)", "%#{params[:term]}%", "%#{params[:term]}%").paginate(page: params[:page], per_page: 12)
    else
      Federation.paginate(page: params[:page], per_page: 12)
    end
  end
  
  def ranking
    @federations = Federation.all
  end

  # GET /federations/1
  # GET /federations/1.json
  def show
    @user = User.find_by(params[:id])
  end

  # GET /federations/new
  def new
    @federation = Federation.new
  end

  # GET /federations/1/edit
  def edit
  end

  # POST /federations
  # POST /federations.json
  def create
    @federation = Federation.new(federation_params)

    respond_to do |format|
      if @federation.save
        format.html { redirect_to @federation, notice: 'Federação criada com sucesso.' }
        format.json { render :show, status: :created, location: @federation }
      else
        format.html { render :new }
        format.json { render json: @federation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /federations/1
  # PATCH/PUT /federations/1.json
  def update
    respond_to do |format|
      if @federation.update(federation_params)
        format.html { redirect_to @federation, notice: 'Federação atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @federation }
      else
        format.html { render :edit }
        format.json { render json: @federation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /federations/1
  # DELETE /federations/1.json
  def destroy
    @federation.destroy
    respond_to do |format|
      format.html { redirect_to federations_url, notice: 'Federação removida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_federation
      @federation = Federation.find(params[:id])
      @ejs = Ej.where(event_id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def federation_params
      params.require(:federation).permit(:name, :state, :members, :icon, :ej, :term)
    end
end
