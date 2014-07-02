class ItemsController < ApplicationController

  before_filter :check_session
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.save
    render :new
  end
  

  private

  def item_params
    params.require(:item).permit(:name, :description, :user_id)
  end
end