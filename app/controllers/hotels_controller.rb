class HotelsController < ApplicationController
  before_action :non_logged_user
  before_action :set_event
  before_action :isnt_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_hotel, only: [:show, :edit, :update, :destroy]
  before_action :first_login
  # CRUD
  def crud
    @hotels = if params[:term]
      Hotel.where("name LIKE (?) OR address LIKE (?)", "%#{params[:term]}%", "%#{params[:term]}%").paginate(page: params[:page], per_page: 5)
    else
      Hotel.paginate(page: params[:page], per_page: 6)
    end
  end
  # GET /hotels
  # GET /hotels.json
  def index
    @hotels = if params[:term]
      Hotel.where("name LIKE (?) OR address LIKE (?)", "%#{params[:term]}%", "%#{params[:term]}%").paginate(page: params[:page], per_page: 5)
    else
      Hotel.paginate(page: params[:page], per_page: 6)
    end
  end

  def spreadsheet
    @hotels = if params[:term]
      render xlsx: 'hotels',template: 'my/template', filename: "my_hotels.xlsx", disposition: 'inline', xlsx_author: "IN Junior"
    end
  end
  
  def show
    @room_user = RoomUser.all
    @rooms = Room.where(hotel_id: @hotel.id).paginate(page: params[:page], per_page: 6)
    @users = User.all
  end

  # GET /hotels/new
  def new
    @hotel = Hotel.new
  end

  # GET /hotels/1/edit
  def edit
  end

  # POST /hotels
  # POST /hotels.json
  def create
    @hotel = Hotel.new(hotel_params)
    @hotel.event = Event.first
    respond_to do |format|
      if @hotel.save
        format.html { redirect_to @hotel, notice: 'Acomodação criada com sucesso.' }
        format.json { render :show, status: :created, location: @hotel }
      else
        format.html { render :new }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /hotels/1
  # PATCH/PUT /hotels/1.json
  def update
    respond_to do |format|
      if @hotel.update(hotel_params)
        format.html { redirect_to @hotel, notice: 'Acomodação atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @hotel }
      else
        format.html { render :edit }
        format.json { render json: @hotel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /hotels/1
  # DELETE /hotels/1.json
  def destroy
    @hotel.destroy
    respond_to do |format|
      format.html { redirect_to hotels_url, notice: 'Acomodação removida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_hotel
      @hotel = Hotel.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def hotel_params
      params.require(:hotel).permit(:name, :photo, :address, :description, :term, :event)
    end
end
