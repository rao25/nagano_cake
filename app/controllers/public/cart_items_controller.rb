class Public::CartItemsController < ApplicationController
  #https://www.sejuku.net/blog/27232
  #https://qiita.com/akmhmgc/items/a40b91aa4f469c397f85
  def create
    @cart_item = current_customer.cart_items.find_by(item_id: params[:item_id])
    if @cart_item.present?
       @cart_item.amount += params[:amount].to_i
    else
       @cart_item = current_customer.cart_items.new(cart_item_params)
    end

    if @cart_item.amount.nil?
      redirect_to request.referer
    elsif  @cart_item.save
      redirect_to cart_items_path
    else
      redirect_to request.referer
    end
  end


  def index
    @cart_items = current_customer.cart_items.all
    @total_price = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    
  end

  def update
    @cart_item = CartItem.find(params[:id])
    @cart_item.update(cart_item_update_params)
    redirect_to cart_items_path
  end

  def destroy
    @cart_item = CartItem.find(params[:id])
    @cart_item.destroy
    redirect_to cart_items_path
  end

  def destroy_all
    @cart_items = current_customer.cart_items.all
    @cart_items.destroy_all
    redirect_to cart_items_path
  end
  
  
  private
    
  def cart_item_params
      params.permit(:item_id, :amount)
  end
  
  def cart_item_update_params
    params.require(:cart_item).permit(:item_id,:amount)
  end
  
end
