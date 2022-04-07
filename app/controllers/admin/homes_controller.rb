class Admin::HomesController < ApplicationController
  before_action :authenticate_admin!
  layout 'admin'
  
  def top
    @orders = Order.all.order(created_at: :desc).page(params[:page])
  end
end
