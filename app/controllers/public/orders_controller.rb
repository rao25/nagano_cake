class Public::OrdersController < ApplicationController

def new
    @order = current_customer.orders.new
    @address = Address.new
end

def confirm
    @order = Order.new(order_params)
    @order.postage = 800
    @order.payment = current_customer.cart_items_total_price + @order.postage
    @cart_items = current_customer.cart_items.all
    @total_price = @cart_items.inject(0) { |sum, item| sum + item.sum_of_price }
    
    if params[:order][:address_option] == "0"
      @order.post_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = "#{current_customer.last_name}#{current_customer.first_name}"
   
    elsif params[:order][:address_option] == "1"
      @address = Address.find(params[:order][:address_id])
      @order.post_code = @address.postal_code
      @order.address = @address.address
      @order.name = @address.name
      
    elsif params[:order][:address_option] == "2"
      @order.post_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    
    end
    
end

  def create
    @order = current_customer.orders.new(order_params)
    @order.save
    current_customer.cart_items.destroy_all
    redirect_to thanks_orders_path
  end

  def index
    @orders = current_customer.orders.order(created_at: :desc)
    @order_details = OrderDetail.all
  end

  def show
    @order = current_customer.orders.find(params[:id])
    @order_details = OrderDetail.all
  end


  private

  def order_params
  params.require(:order).permit(:payment_method, :payment, :post_code, :address, :name, :postage)
  end

  def address_params
    params.permit(:name,:address,:post_code)
  end
  
end