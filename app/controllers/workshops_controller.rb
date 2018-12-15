class WorkshopsController < ApplicationController
  before_action :non_logged_user
  before_action :set_event
  before_action :set_workshop, only: [:show, :edit, :update, :destroy]
  before_action :workshop_period, only: [:show]
  before_action :isnt_admin, except:[:index, :inscription, :show]
  before_action :first_login
  
  # relationship Workshop-User
  def inscription
    @event = Event.first
    if current_user.payment_status? && @event != nil && @event.activity_begin_day < DateTime.now < @event.activity_end_day
      insc = WorkUser.find_by(workshop_id: params[:id], user_id: current_user.id)
      if Workshop.find(params[:id]).vacancies > 0 
        if insc.nil?
          WorkUser.create(workshop_id: params[:id], user_id: current_user.id)
          Workshop.update(params[:id], :vacancies => Workshop.find(params[:id]).vacancies - 1)
        else 
          insc.destroy
          Workshop.update(params[:id], :vacancies => Workshop.find(params[:id]).vacancies + 1)
        end 
        redirect_to workshops_path
      else
        redirect_to workshops_path
      end
    else
      flash[:error] = "Inscrição inválida, tente novamente"
      redirect_to workshops_path
    end 
  end
  
  # Relationship Workshop-Staff
  def add_work_staff
    WorkStaff.create(workshop_id: params[:id], staff_id: params[:work_staff][:staff_id])
    redirect_to workshop_path
  end
  
  # GET /workshops
  # GET /workshops.json
  def index
    @workusers = WorkUser.all
    @work_staffs = WorkStaff.all
    @workshops = if Category.find_by(kind: params[:term])
      Workshop.where('title LIKE (?) OR category_id LIKE (?)', "%#{params[:term]}%", 
      "%#{Category.find_by(kind: params[:term]).id}%").paginate(page: params[:page], per_page: 6)
    else
      Workshop.where('title LIKE (?)', "%#{params[:term]}%").paginate(page: params[:page], per_page: 6)
    end
  end

  # GET /workshops/1
  # GET /workshops/1.json
  def show
    @workshops = Workshop.all
    @workusers = WorkUser.all
    @work_staffs = WorkStaff.where(workshop_id: params[:id])
    @work_staff = WorkStaff.new
    @staffs = Staff.all
    @archive = Archive.new
  end

  # GET /workshops/new
  def new
    @workshop = Workshop.new
    @events = Event.all
    @categorys = Category.all
  end

  # GET /workshops/1/edit
  def edit
    @categorys = Category.all
    @events = Event.all
  end

  # POST /workshops
  # POST /workshops.json
  def create
    @workshop = Workshop.new(workshop_params)

    respond_to do |format|
      if @workshop.save
        format.html { redirect_to @workshop, notice: 'Workshop criado com sucesso.' }
        format.json { render :show, status: :created, location: @workshop }
      else
        format.html { render :new }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /workshops/1
  # PATCH/PUT /workshops/1.json
  def update
    respond_to do |format|
      if @workshop.update(workshop_params)
        format.html { redirect_to @workshop, notice: 'Workshop atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @workshop }
      else
        format.html { render :edit }
        format.json { render json: @workshop.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /workshops/1
  # DELETE /workshops/1.json
  def destroy
    @workshop.destroy
    respond_to do |format|
      format.html { redirect_to workshops_url, notice: 'Workshop removido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_workshop
      @workshop = Workshop.find(params[:id])
      @archives = Archive.where(workshop_id: params[:id])
      @staffs = Staff.where(staff_id: params[:id])
      @categorys = Category.where(category_id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def workshop_params
      params.require(:workshop).permit(:the_day, :begin_day, :end_day, :availability, :vacancies, :description, 
                     :event_id, :title, :term, :arquive, :attachment, :event, :category)
    end
end
