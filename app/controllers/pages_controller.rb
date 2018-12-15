class PagesController < ApplicationController
    before_action :non_logged_user
    before_action :isnt_admin, only: [:controlpanel]
    before_action :set_event
    before_action :first_login
    
    def category_from_controller
        @category = Category.new(category_params)
        respond_to do |format|
            if @category.save
                format.html { redirect_to :control_panel, notice: 'Categoia adicionada com sucesso.' }
                format.json { render :show, status: :created, location: @category }
            else
                format.html { redirect_to :control_panel }
                format.json { render json: @category.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def remove_category
        category = Category.find(params[:id])
        category.destroy
        redirect_to control_panel_url
    end
    
    def hotel_from_controller
        @hotel = Hotel.new(hotel_params)
        respond_to do |format|
            if @hotel.save
                format.html { redirect_to @hotel, notice: 'Acomodação criada com sucesso.' }
                format.json { render :show, status: :created, location: @hotel }
            else
                format.html { redirect_to control_panel }
                format.json { render json: @hotel.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def room_from_controller
        @room = Room.new(room_params)
        respond_to do |format|
            if @room.save
                format.html { redirect_to @room, notice: 'Quarto criado com sucesso.' }
                format.json { render :show, status: :created, location: @room }
            else
                format.html { redirect_to control_panel }
                format.json { render json: @room.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def lecture_from_controller
        @lecture = Lecture.new(lecture_params)
        respond_to do |format|
            if @lecture.save
                format.html { redirect_to @lecture, notice: 'Palestra criada com sucesso.' }
                format.json { render :show, status: :created, location: @lecture }
            else
                format.html { redirect_to control_panel }
                format.json { render json: @lecture.errors, status: :unprocessable_entity }
            end
        end
    end
    
    def workshop_from_controller
        @workshop = Workshop.new(workshop_params)
        respond_to do |format|
            if @workshop.save
                format.html { redirect_to @workshop, notice: 'Workshop criado com sucesso.' }
                format.json { render :show, status: :created, location: @workshop }
            else
                format.html { redirect_to control_panel }
                format.json { render json: @workshop.errors, status: :unprocessable_entity }
            end
        end
    end
    
    # Define caminho pra page
    def show
        @federations = Federation.all
        @ejs = Ej.all
        @workshop = Workshop.find_by(params[:id])
        @lecture = Lecture.find_by(params[:id])
        @lec_user = LecUser.where(user_id: current_user.id)
        @work_user = WorkUser.where(user_id: current_user.id)
        @event = Event.first
        
        render template: "pages/#{params[:page]}"
    end
    
    def controlpanel
        @hotel = Hotel.new
        @room = Room.new
        @lecture = Lecture.new
        @workshop = Workshop.new
        @category = Category.new
        
        @events = Event.all
        @categorys = Category.all
        @hotels = Hotel.all
    end
    
    def blocker
    end
    
    private
    
    # Permite certos parametros serem passados pra pagina
    def pages_params
        params.require(:user).permit(:name, :last_name, :photo)
    end
    
    def hotel_params
        params.require(:hotel).permit(:name, :photo, :address, :description, :term)
    end
    
    def room_params
        params.require(:room).permit(:number, :photo, :availability, :bed_one, :bed_two, :hotel_id)
    end
    
    def lecture_params
      params.require(:lecture).permit(:title, :description, :the_day, :begin_day, :end_day, :availability, :vacancies, 
                     :event_id, :term, :arquive, :attachment, :event, :category)
    end
    
    def category_params
      params.require(:category).permit(:kind)
    end
    
    def workshop_params
      params.require(:workshop).permit(:the_day, :begin_day, :end_day, :availability, :vacancies, :description, 
                     :event_id, :title, :term, :arquive, :attachment, :event, :category)
    end
end  