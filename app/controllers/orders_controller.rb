class OrdersController < ShopifyApp::AuthenticatedController
  before_action :set_order, only: [:show, :edit, :var_post, :update, :destroy]

  # GET /orders
  # GET /orders.json
  def index
    @unfulfilled = 'Unfulfilled'
    @orders = ShopifyAPI::Order.find(:all, params: { limit: 250 })
    @products = ShopifyAPI::Product.find(:all)
    #@orders = ShopifyAPI::Order.find(:all, params: { created_at_min: (Time.now - 30.days), limit: 250 })
    #@line_items = ShopifyAPI::LineItem.find(:all)
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

  def var_post
    cur_tags = []
    new_tags = [] 
    if params[:id].present?

      cur_tags = @order.tags.split(", ").map(&:strip)
      
      #temp_app_tag = params[:tags] 
      app_tag = params[:tags]      
    
      for i in 0..cur_tags.length-1
        @order.line_items.each do |item| 
          if cur_tags[i][0,14] != "#{item.id}:"
          new_tags << cur_tags[i]
          end #end-if
        end #end-loop
      end #end-for
       
      new_tags << app_tag
      
      @order.tags = new_tags.join(', ')     

    @order.save
      respond_to do |format|
        format.html { redirect_to orders_url, notice: 'Order status was successfully updated..'}
        format.json { head :no_content }      
      end
    end
  end

  # PATCH/PUT /orders/1
  # PATCH/PUT /orders/1.json
  def order_post
    @order = ShopifyAPI::Order.find(params[:id])

    cur_tags = []
    new_tags = [] 
    if params[:id].present?

      cur_tags = @order.tags.split(", ").map(&:strip)
      
      #temp_app_tag = params[:tags] 
      app_tag = params[:tags]      
    
      for i in 0..cur_tags.length-1     
        if cur_tags[i][0,7] != "Status:"
        new_tags << cur_tags[i]
        end #end-if
      end #end-for
       
      new_tags << app_tag
      
      @order.tags = new_tags.join(", ")     

    @order.save
      respond_to do |format|
        format.html { redirect_to orders_url, notice: 'Order status was successfully updated..'}
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
