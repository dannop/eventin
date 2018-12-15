class WorkStaffsController < ApplicationController
  before_action :set_work_staff, only: [:show, :edit, :update, :destroy]
  before_action :isnt_admin

  # GET /work_staffs
  # GET /work_staffs.json
  def index
    @work_staffs = WorkStaff.all
  end

  # GET /work_staffs/1
  # GET /work_staffs/1.json
  def show
  end

  # GET /work_staffs/new
  def new
    @work_staff = WorkStaff.new
    @workshops = Workshop.all
    @staffs = Staff.all
  end

  # GET /work_staffs/1/edit
  def edit
    @workshops = Workshop.all
    @staffs = Staff.all
  end

  # POST /work_staffs
  # POST /work_staffs.json
  def create
    @work_staff = WorkStaff.new(work_staff_params)

    respond_to do |format|
      if @work_staff.save
        format.html { redirect_to @work_staff, notice: 'Staff adicionada com sucesso.' }
        format.json { render :show, status: :created, location: @work_staff }
      else
        format.html { render :new }
        format.json { render json: @work_staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /work_staffs/1
  # PATCH/PUT /work_staffs/1.json
  def update
    respond_to do |format|
      if @work_staff.update(work_staff_params)
        format.html { redirect_to @work_staff, notice: 'Staff atualizada com sucesso.' }
        format.json { render :show, status: :ok, location: @work_staff }
      else
        format.html { render :edit }
        format.json { render json: @work_staff.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /work_staffs/1
  # DELETE /work_staffs/1.json
  def destroy
    worksh = Workshop.find(@work_staff.workshop_id)
    @work_staff.destroy
    respond_to do |format|
      format.html { redirect_to workshop_path(worksh), notice: 'Staff removido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_work_staff
      @work_staff = WorkStaff.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def work_staff_params
      params.require(:work_staff).permit(:staff_id, :workshop_id)
    end
end
