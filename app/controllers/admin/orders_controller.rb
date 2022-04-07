class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'
  
  def index
     @orders = Order.all.order(created_at: :desc).page(params[:page])
  end

  def show
    @order = Order.find(params[:id])
    @order.postage = 800
  end

  def update
  	@order = Order.find(params[:id])
    @order_details = @order.order_details
    if params[:order][:status] == "confirmed_payment"
        @order_details.each do |order_detail|
          order_detail.update(making_status: "wating_for_make")
        end
    end
    @order.update(order_params)
    redirect_to admin_order_path(@order)
  end



  private

  def order_params
    params.require(:order).permit(:status)
  end
end
