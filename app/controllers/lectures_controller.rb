class LecturesController < ApplicationController
  before_action :non_logged_user
  before_action :set_event
  before_action :set_lecture, only: [:show, :edit, :update, :destroy, :add_lec_staff]
  before_action :lecture_period, only: [:show]
  before_action :isnt_admin, except:[:index, :inscription, :show]
  before_action :first_login
  
  # relationship Lecture-User
  def inscription
    @event = Event.first
    if current_user.payment_status? && @event != nil && @event.activity_begin_day < DateTime.now < @event.activity_end_day
      insc = LecUser.find_by(lecture_id: params[:id], user_id: current_user.id)
      if Lecture.find(params[:id]).vacancies > 0 or insc
        if insc.nil?
          LecUser.create(lecture_id: params[:id], user_id: current_user.id)
          Lecture.update(params[:id], :vacancies => Lecture.find(params[:id]).vacancies-1)
        else 
          insc.destroy
          Lecture.update(params[:id], :vacancies => Lecture.find(params[:id]).vacancies + 1)
        end 
        redirect_to lectures_path
      else
        redirect_to lectures_path
      end
    else
      flash[:error] = "Inscrição inválida, tente novamente"
      redirect_to lectures_path
    end
  end
  
  # Relationship Lecture-Staff
  def add_lec_staff
    @lecstaff = LecStaff.new(lecture_id: params[:id], staff_id: params[:lec_staff][:staff_id])
    @lecstaff.save
    redirect_to lecture_path
  end
  
  # GET /lectures
  # GET /lectures.json
  def index #Company.joins(:jobs).group("jobs.company_id").order("count(jobs.company_id) desc")
    @categorys = Category.joins(:lectures).group("lectures.category_id").order('COUNT(lectures.id) DESC').limit(3) #Company.joins(:jobs).group("jobs.company_id").order("count(jobs.company_id) desc")
    @predefined_category = Category.limit(3)
    @category = Category.find_by(params[:id])
    @lecusers = LecUser.all
    @lec_staffs = LecStaff.all
    @lectures = 
    if params[:commit]
      Lecture.where('category_id LIKE (?)', "%#{Category.find_by(kind: params[:commit]).id}%").paginate(page: params[:page], per_page: 6)
    else
      if Category.find_by(kind: params[:term])
        Lecture.where('title LIKE (?) OR category_id LIKE (?)', "%#{params[:term]}%",
        "%#{Category.find_by(kind: params[:term]).id}%").paginate(page: params[:page], per_page: 6)
      else
      Lecture.where('title LIKE (?)', "%#{params[:term]}%").paginate(page: params[:page], per_page: 6)
      end
    end
  end

  # GET /lectures/1
  # GET /lectures/1.json
  def show
    @lectures = Lecture.all
    @lecusers = LecUser.all
    @lec_staffs = LecStaff.where(lecture_id: params[:id])
    @lec_staff = LecStaff.new
    @staffs = Staff.all
    @archive = Archive.new
  end

  # GET /lectures/new
  def new
    @lecture = Lecture.new
    @events = Event.all
    @categorys = Category.all
  end

  # GET /lectures/1/edit
  def edit
    @events = Event.all
    @categorys = Category.all
  end

  # POST /lectures
  # POST /lectures.json
  def create
    @lecture = Lecture.new(lecture_params)
    @lecture.event_id = Event.first.id
    respond_to do |format|
      if @lecture.save
        format.html { redirect_to @lecture, notice: 'Palestra criada com sucesso.' }
        format.json { render :show, status: :created, location: @lecture }
      else
        format.html { render :new }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lectures/1
  # PATCH/PUT /lectures/1.json
  def update
    respond_to do |format|
      if @lecture.update(lecture_params)
        format.html { redirect_to @lecture, notice: 'Palestra atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @lecture }
      else
        format.html { render :edit }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lectures/1
  # DELETE /lectures/1.json
  def destroy
    @lecture.destroy
    respond_to do |format|
      format.html { redirect_to root, notice: 'Palestra removida com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lecture
      @lecture = Lecture.find(params[:id])
      @archives = Archive.where(lecture_id: params[:id])
      @staffs = Staff.where(staff_id: params[:id])
      @categorys = Category.where(category_id: params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lecture_params
      params.require(:lecture).permit(:title, :description, :the_day, :begin_day, :end_day, :availability, :vacancies, 
                     :event_id, :term, :arquive, :attachment, :event, :category_id)
    end
    
    
end
