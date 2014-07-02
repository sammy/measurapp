class ItemsController < ApplicationController

  before_filter :check_session
  
  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = @current_user.id
    if @item.save
      flash[:success] = "Item #{@item.name} has been succesfully created"
      redirect_to new_item_path
    else
      flash[:error] = @item.errors.full_messages
      render :new
    end
  end
  

  private

  def item_params
    params.require(:item).permit(:name, :description, :user_id)
  end
end