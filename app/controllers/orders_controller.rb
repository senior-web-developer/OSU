class OrdersController < ShopifyApp::AuthenticatedController
  before_action :set_order, only: [:show, :edit, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @unfulfilled = 'Unfulfilled'
    @orders = ShopifyAPI::Order.find(:all, params: { limit: 250 })
    @products = ShopifyAPI::Product.find(:all)
    #@orders = ShopifyAPI::Order.find(:all, params: { created_at_min: (Time.now - 30.days), limit: 250 })
    #@line_items = ShopifyAPI::LineItem.find(:all)
  end

  # GET /orders/1
  # GET /orders/1.json
  def show
    @order = ShopifyAPI::Order.find(params[:id])
  end

  # GET /orders/new
  def new
    @order = ShopifyAPI::Order.new
  end

  # GET /orders/1/edit
  def edit
  end

  # POST /orders
  # POST /orders.json
  def create
    @order = ShopifyAPI::Order.save(order_params)

    respond_to do |format|
      if @order.save
        format.html { redirect_to @order, notice: 'Order was successfully created.' }
        format.json { render :show, status: :created, location: @order }
      else
        format.html { render :new }
        format.json { render json: @order.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def update
    cur_tag = []
    new_tag = []
    updated_tags = []
    @order = ShopifyAPI::Order.find(params[:id])
    cur_tag = @order.tags 
    new_tag = params[:tags]
    #updated_tags = params[:tags]
    if params[:id].present?
      #tag = %w[cur_tag] 
      new_tag.split(',')
      cur_tag.split(',')
      #@order.tags = tags.uniq.join(',')
      [cur_tag] + = [new_tag]
      @order.tags = [cur_tag]
      @order.save
      respond_to do |format|
        format.html { redirect_to orders_url, notice: 'Order was successfully updated..' }
        format.json { head :no_content }
      end
    end     
    #redirect_to '/orders/index'       
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_order
      @order = ShopifyAPI::Order.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:tags)
    end
end
