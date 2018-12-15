class LecStaffsController < ApplicationController
  before_action :set_lec_staff, only: [:show, :edit, :update, :destroy]

  # GET /lec_staffs
  # GET /lec_staffs.json
  def index
    @lec_staffs = LecStaff.all
  end

  # GET /lec_staffs/1
  # GET /lec_staffs/1.json
  def show
  end

  # GET /lec_staffs/new
  def new
    @lec_staff = LecStaff.new
    @lectures = Lecture.all
    @staffs = Staff.all
  end

  # GET /lec_staffs/1/edit
  def edit
    @lectures = Lecture.all
    @staffs = Staff.all
  end

  # POST /lec_staffs
  # POST /lec_staffs.json
  def create
    @lec_staff = LecStaff.new(lec_staff_params)

    respond_to do |format|
      if @lec_staff.save
        format.html { redirect_to @lec_staff, notice: 'Staff adicionada com sucesso.' }
        format.json { render :show, status: :created, location: @lec_staff }
      else
        format.html { render :new }
        format.json { render json: @lec_staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lec_staffs/1
  # PATCH/PUT /lec_staffs/1.json
  def update
    respond_to do |format|
      if @lec_staff.update(lec_staff_params)
        format.html { redirect_to @lec_staff, notice: 'Staff actualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @lec_staff }
      else
        format.html { render :edit }
        format.json { render json: @lec_staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lec_staffs/1
  # DELETE /lec_staffs/1.json
  def destroy
    lect = Lecture.find(@lec_staff.lecture_id)
    @lec_staff.destroy
    respond_to do |format|
      format.html { redirect_to lecture_path(lect), notice: 'Staff removido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lec_staff
      @lec_staff = LecStaff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lec_staff_params
      params.require(:lec_staff).permit(:staff_id, :lecture_id)
    end
end
