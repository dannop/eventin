class ArchivesController < ApplicationController
   before_action :set_archive, only: [:show, :edit, :update, :destroy]
   before_action :non_logged_user
   before_action :isnt_admin, only: [:new, :create, :edit, :update, :destroy]
   before_action :set_event
   before_action :first_login
   
   def index
      @archives = Archive.all
   end
   
   def new
      @archive = Archive.new
      @lectures = Lecture.all
      @workshops = Workshop.all
   end
   
   def create
      @archive = Archive.new(archive_params)
      if @archive.save
         if current_user.adm?
            redirect_to archives_path, notice: "O arquivo #{@archive.name} foi enviado."
         else
            redirect_to archives_path, notice: "O arquivo #{@archive.name} foi enviado."
         end
      else
         render "new"
      end
      
   end
   
   def destroy
      @archive.destroy
      redirect_to archives_path, notice:  "O arquivo #{@archive.name} foi removido."
   end
   
   def set_archive
      @archive = Archive.find(params[:id])
   end
   
   private
   
   def archive_params
      params.require(:archive).permit(:name, :attachment, :description, :lecture_id, :workshop_id)
   end
   
end
