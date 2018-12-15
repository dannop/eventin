class CheckoutsController < ApplicationController
  before_action :non_logged_user
  before_action :set_checkout, only: [:show, :edit, :update, :destroy]

  def index
    @checkouts = Checkout.all
  end

  def show
  end

  def new
    @checkout = Checkout.new
    @lots = Lot.where(purchasable: true).limit(1)
  end

  def edit
  end

  def create
    @checkout = Checkout.new(checkout_params)
    @lot = Lot.find_by(params[:id])
    
    payment = PagSeguro::PaymentRequest.new

    payment.reference = @checkout.id
    payment.notification_url = root_url
    payment.redirect_url = pagamento_url
    
    payment.sender = {
      email: "c93424764302233784709@sandbox.pagseguro.com.br",
      cpf: @current_user.cpf
    }

    payment.items << {
      id: @checkout[:lot_id],
      description: current_user.id.to_s + "/" + @checkout[:lot_id].to_s + "/" + Lot.find(@checkout[:lot_id]).event.name,
      amount: @lot.price
    }
    
    response = payment.register

    # Caso o processo de checkout tenha dado errado, lança uma exceção.
    # Assim, um serviço de rastreamento de exceções ou até mesmo a gem
    # exception_notification poderá notificar sobre o ocorrido.
    #
    # Se estiver tudo certo, redireciona o comprador para o PagSeguro.
    if response.errors.any?
      raise response.errors.join("\n")
    else
      redirect_to response.url
    end
  end
  
  def create_with_room
    @checkout = Checkout.new(checkout_params)
    @lot = Lot.find_by(params[:id])
    
    payment = PagSeguro::PaymentRequest.new

    payment.reference = @checkout.id
    payment.notification_url = root_url
    payment.redirect_url = pagamento_url
    
    payment.sender = {
      email: "c93424764302233784709@sandbox.pagseguro.com.br",
      cpf: @current_user.cpf
    }

    payment.items << {
      id: @checkout[:lot_id],
      description: current_user.id.to_s + "/" + @checkout[:lot_id].to_s + "/" + Lot.find(@checkout[:lot_id]).event.name,
      amount: @lot.room_with + @lot.price
    }
    
    response = payment.register

    # Caso o processo de checkout tenha dado errado, lança uma exceção.
    # Assim, um serviço de rastreamento de exceções ou até mesmo a gem
    # exception_notification poderá notificar sobre o ocorrido.
    #
    # Se estiver tudo certo, redireciona o comprador para o PagSeguro.
    if response.errors.any?
      raise response.errors.join("\n")
    else
      redirect_to response.url
    end
  end

  # PATCH/PUT /checkouts/1
  # PATCH/PUT /checkouts/1.json
  def update
    respond_to do |format|
      if @checkout.update(checkout_params)
        format.html { redirect_to @checkout, notice: 'Checkout was successfully updated.' }
        format.json { render :show, status: :ok, location: @checkout }
      else
        format.html { render :edit }
        format.json { render json: @checkout.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /checkouts/1
  # DELETE /checkouts/1.json
  def destroy
    @checkout.destroy
    respond_to do |format|
      format.html { redirect_to checkouts_url, notice: 'Checkout was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_checkout
      @checkout = Checkout.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def checkout_params
      params.require(:checkout).permit(:ticket_id, :lot_id, :price, :status, :buyer_name, :reference)
    end
end
