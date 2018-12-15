class EventsController < ApplicationController
  before_action :non_logged_user
  before_action :set_event, except: [:new, :create]
  before_action :isnt_admin, only: [:new, :create, :edit, :update, :destroy]
  before_action :set_the_event, only: [:show, :edit, :update, :destroy]
  before_action :only_event, only: [:new, :create]
  before_action :first_login
  
  
  def only_event
    @events = Event.all
    if @events.count >= 1
      redirect_to events_path
    end
  end
  
  
  # GET /events
  # GET /events.json
  def index
    @events = Event.all
    @lecture = Lecture.find(1)
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    if Event.first == nil
      @event = Event.new
    else 
      respond_to do |format|
        format.html { redirect_to events_url, notice: 'Ja existe um evento em andamento.' }
      end  
    end
  end

  # GET /events/1/edit
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    @event = Event.new(event_params)
    if Event.first == nil 
      respond_to do |format|
        if @event.save
          format.html { redirect_to @event, notice: 'Evento criado com sucesso.' }
          format.json { render :show, status: :created, location: @event }
        else
          format.html { render :new }
          format.json { render json: @event.errors, status: :unprocessable_entity }
        end
      end
    else 
      respond_to do |format|
        format.html { redirect_to events_url, notice: 'Ja existe um evento em andamento.' }
      end  
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Evento atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Evento criado com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_the_event
      @event = Event.find(params[:id])
      @lectures = Lecture.where(event_id: params[:id])
      @workshops = Workshop.where(event_id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def event_params
      params.require(:event).permit(:name, :begin_day, :end_day, :activity_begin_day, :activity_end_day,
                                    :room_begin_day, :room_end_day, :description, :lecture, :workshop)
    end
end
