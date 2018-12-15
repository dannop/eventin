class LotsController < ApplicationController
  before_action :non_logged_user
  before_action :set_event
  before_action :set_lot, only: [:show, :edit, :update, :destroy]
  before_action :isnt_admin
  
  def index
    @lots = Lot.paginate(page: params[:page], per_page: 6)
  end
  
  def crud
    @lots = Lot.paginate(page: params[:page], per_page: 6)
  end
  
  
  def update_availability
    @lots = Lot.all
    @lot = Lot.find(params[:id])
    if @lot.purchasable?
      @lot.purchasable = false
      @lot.save
      respond_to do |format|
        format.html { redirect_to lots_path, notice: 'Lote desativado com sucesso' }
        format.js
      end
    else
      lots = Lot.all
      lots.each do |t|
        t.purchasable = false
        t.save
      @lot.purchasable = true
      @lot.save
      end
      respond_to do |format|
        format.html { redirect_to lots_path, notice: 'Lote ativado com sucesso' }
        format.js
      end
    end
  end
  
  
  # GET /lots/1
  # GET /lots/1.json
  def show
  end

  # GET /lots/new
  def new
    @lot = Lot.new
  end

  # GET /lots/1/edit
  def edit
  end

  # POST /lots
  # POST /lots.json
  def create
    @lot = Lot.new(lot_params)

    respond_to do |format|
      if @lot.save
        format.html { redirect_to @lot, notice: 'Lot criado com sucesso.' }
        format.json { render :show, status: :created, location: @lot }
      else
        format.html { render :new }
        format.json { render json: @lot.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /lots/1
  # PATCH/PUT /lots/1.json
  def update
    respond_to do |format|
      if @lot.update(lot_params)
        format.html { redirect_to @lot, notice: 'Lot atualizado com sucesso.' }
        format.json { render :show, status: :ok, location: @lot }
      else
        format.html { render :edit }
        format.json { render json: @lot.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lots/1
  # DELETE /lots/1.json
  def destroy
    @lot.destroy
    respond_to do |format|
      format.html { redirect_to lots_url, notice: 'Lot removido com sucesso.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lot
      @lot = Lot.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def lot_params
      params.require(:lot).permit(:price, :event_id, :ticket_current, :close_date, 
        :open_date, :purchasable, :event_id, :ticket_total, :room_with, :room_check)
    end
end
