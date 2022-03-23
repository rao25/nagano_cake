class Public::ItemsController < ApplicationController
  def index
    @items = Item.page(params[:page]).per(10)
    @genres = Genre.all
  end

  def show
    @item = Item.find(params[:id])
    @genres = Genre.all
  end
end
