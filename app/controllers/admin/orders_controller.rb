class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'
  
  def index
     @orders = Order.all
  end

  def show
    @order = Order.find(params[:id])
    @order.postage = 800
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end
end