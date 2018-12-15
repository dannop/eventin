class RoomsController < ApplicationController
  before_action :set_room, only: [:show, :edit, :update, :destroy, :inscription]
  before_action :non_logged_user
  before_action :set_event
  before_action :first_login
  
  #Room Inscription
    
  def inscription
    @event = Event.first
    if current_user.payment_status? && @event != nil && @event.room_begin_day < DateTime.now < @event.room_end_day
      if current_user.room_id == @room.id
        current_user.room_id = nil
        current_user.save
        redirect_to Hotel.find(Room.find(params[:id]).hotel_id)
      else
        current_user.room_id = @room.id
        current_user.save
        redirect_to Hotel.find(Room.find(params[:id]).hotel_id)
      end
    else
      flash[:error] = "Registro inválido, tente novamente"
      redirect_to hotels_path
    end
  end
  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.paginate(page: params[:page], per_page: 6)
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
    @roomusers = RoomUser.all
  end

  # GET /rooms/new
  def new
    @room = Room.new
    @hotels = Hotel.all
  end

  # GET /rooms/1/edit
  def edit
    @hotels = Hotel.all
  end

  # POST /rooms
  # POST /rooms.json
  def create
    @room = Room.new(room_params)

    respond_to do |format|
      if @room.save
        format.html { redirect_to @room, notice: 'Quarto criado com sucesso.' }
        format.json { render :show, status: :created, location: @room }
      else
        format.html { render :new }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /rooms/1
  # PATCH/PUT /rooms/1.json
  def update
    respond_to do |format|
      if @room.update(room_params)
        format.html { redirect_to @room, notice: 'Quarto atulizado com sucesso.' }
        format.json { render :show, status: :ok, location: @room }
      else
        format.html { render :edit }
        format.json { render json: @room.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rooms/1
  # DELETE /rooms/1.json
  def destroy
    @room.destroy
    respond_to do |format|
      format.html { redirect_to rooms_url, notice: 'Quarto removido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_room
      @room = Room.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def room_params
      params.require(:room).permit(:availability, :photo, :bed_two, :bed_one, :number, :hotel_id)
    end
end
