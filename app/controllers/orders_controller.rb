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
    cur_tag = []
    new_tag = []
    @order = ShopifyAPI::Order.find(params[:id])
    cur_tag = @order.tags    
    cur_tag.split(',').map
    var_tag = params[:variant_tag]

    if params[:id].present?      
      #@order.tags = tags.uniq.join(',')
      cur_tag = [cur_tag] + [var_tag]
      @order.tags = cur_tag     

      @order.save
      respond_to do |format|
        format.html { redirect_to orders_url, notice: 'Variant product status was successfully updated..' }
        format.json { head :no_content }
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
    cur_tag.split(',').map
    new_tag = params[:tags]

    if params[:id].present?      
      #@order.tags = tags.uniq.join(',')
      #cur_tag = [cur_tag] + [new_tag]
      #@order.tags = cur_tag
      cur_tag = [cur_tag] + [new_tag]
      @order.tags = cur_tag

      for i in 1..10 do        
        if cur_tag[i] === new.gsub("STATUS")
          puts cur_tag[i]
          cur_tag[i] = [new_tag]
          @order.tags = cur_tag   
        end
      end

      @order.save
      respond_to do |format|
        format.html { redirect_to orders_url, notice: 'Order status was successfully updated..' }
        format.json { head :no_content }
      end
    end            
  end

  # DELETE /orders/1
  # DELETE /orders/1.json
  def destroy
    @order.destroy
    respond_to do |format|
      format.html { redirect_to orders_url, notice: 'Order status was successfully destroyed.' }
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
