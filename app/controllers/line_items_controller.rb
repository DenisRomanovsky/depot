class LineItemsController < ApplicationController
  include CurrentCart
  skip_before_action :authorize, only: :create
  before_action :set_cart, only: [:create] #creates a session if not created.

  before_action :set_line_item, only: [:show, :edit, :update, :destroy]

  # GET /line_items
  # GET /line_items.json
  def index
    @line_items = LineItem.all
  end

  # GET /line_items/1
  # GET /line_items/1.json
  def show
  end

  # GET /line_items/new
  def new
    @line_item = LineItem.new
  end

  # GET /line_items/1/edit
  def edit
  end

  # POST /line_items
  # POST /line_items.json
  def create
    product = Product.find(params[:product_id]) #Ловим параметр, созданный кнопкой Add To Cart.
    @line_item =  @cart.add_product(product.id)#Автоматом создаёт связи согласно модели внутри, через Build.

    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_url }
        format.js {@current_item = @line_item}
        format.json { render action: 'show', status: :created, location: @line_item }
      else
        format.html { redirect_to store_url, notice: "Can`t add this item."}
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /line_items/1
  # PATCH/PUT /line_items/1.json
  def update
    respond_to do |format|
      if @line_item.update(line_item_params)
        format.html { redirect_to @line_item, notice: 'Line item was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /line_items/1
  # DELETE /line_items/1.json
  def destroy
    cart_id = @line_item.cart_id
    if cart_id == session[:cart_id]
     @line_item = LineItem.find(params[:id])
        @line_item.destroy
        respond_to do |format|
          format.html { redirect_to store_path}
            format.js {@cart = @line_item.cart}
          format.json { head :no_content }
        end
    else
      respond_to do |format|
            format.html { redirect_to store_url, notice: "Your cart was not deleted. Please, contact us, if this isuue occurs again." }
      logger.error "Attempt to view delete a cart using fake session id. Session ID: #{session[:cart_id]} , Cart ID #{cart_id}"
      end
    end
  end


  def decrement
    @cart = Cart.find_by_id(session[:cart_id])
    @line_item = @cart.decrement_line_item_quantity(params[:id]) if @cart.line_items.find_by_id(params[:id]) # Параметр передается имплицитно, без явного определния в кнопке.
    respond_to do |format|
      if @line_item.save
        format.html { redirect_to store_path, notice: 'Line item was successfully updated.' }
        format.js {@current_item = @line_item}
        format.json { head :ok }
      else
        format.html { redirect_to store_url, notice: "Line Item quantity was not changed." }
        format.js { redirect_to store_url, notice: "Line Item quantity was not changed." }
        format.json { render json: @line_item.errors, status: :unprocessable_entity }
      end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_line_item
      @line_item = LineItem.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def line_item_params
      params.require(:line_item).permit(:product_id)
    end
end
