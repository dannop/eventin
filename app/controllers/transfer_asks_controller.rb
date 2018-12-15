class TransferAsksController < ApplicationController
  
  def index
    @transferasks = 
    if params[:term]
        TransferAsk.where("asker_id IS (SELECT id FROM users WHERE name LIKE (?)) OR replyer_id IS (SELECT id FROM users WHERE name LIKE (?))",
        "%#{params[:term]}%", "%#{params[:term]}%").paginate(page: params[:page], per_page: 20)
    else
      TransferAsk.paginate(page: params[:page], per_page: 20)
    end
  end
  
  def new
    @transferask = TransferAsk.new
    @users  = User.all
    @replyer = TransferAsk.find_by(asker_id: params[:id])
    @asker = TransferAsk.find_by(replyer_id: params[:id])
  end
  
  def create
    @transferask = TransferAsk.new(transferask_params)
    respond_to do |format|
      if @transferask.asker.payment_status == true
        format.html { redirect_to new_transfer_path, notice: 'O receptor já realizou o pagamento.' }
        format.json { render :show, status: :created, location: @transferask }
      else
        if @transferask.replyer.payment_status == false
          format.html { redirect_to new_transfer_path, notice: 'O emitente ainda não realizou o pagamento.' }
          format.json { render :show, status: :created, location: @transferask }
        else
          if @transferask.save
            @replyer = User.find(@transferask.replyer_id)
            @asker = User.find(@transferask.asker_id)
            @replyer.payment_status = false
            @asker.payment_status = true
            @replyer.save
            @asker.save
            format.html { redirect_to transfers_path, notice: 'Transferência efetuada.' }
            format.json { render :show, status: :created, location: @transferask }
          else
            format.html { render :new }
            format.json { render json: @transferask.errors, status: :unprocessable_entity }
          end
        end
      end
    end
  end
  
  def create_askout
    askout  = TransferAsk.find_by(asker_id: params[:id], replyer_id: current_user.id)
    if askout
      redirect_to user_path(params[:id])
    else
      @ta = TransferAsk.new
      @ta.asker_id = params[:id]
      @ta.replyer_id = current_user.id
      @ta.save
      redirect_to asks_path
    end
  end
  
  def confirm
    @acceptance = TransferAsk.find(params[:id])
    @user = User.find(current_user.id)
    if @acceptance.replyer_id == current_user.id
      @receiver = User.find(@acceptance.asker_id)
      @user.payment_status = false
      @user.save
      @receiver.payment_status = true
      @receiver.save
      @acceptance.destroy
      redirect_to current_user
    else
      redirect_to current_user
    end
  end
  
  private
  
  def transferask_params
    params.require(:transfer_ask).permit(:asker_id, :replyer_id, :term)
  end
end