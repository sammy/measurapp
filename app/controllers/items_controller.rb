class ItemsController < ApplicationController

  before_filter :check_session
  
  def new
    @item = Item.new
    @groups = @current_user.groups
  end

  def create
    @item = Item.new(item_params)
    @item.user_id = @current_user.id
    if @item.save
      flash[:success] = "Item #{@item.name.upcase} has been succesfully created"
      redirect_to new_item_path
    else
      flash[:error] = @item.errors.full_messages
      render :new
    end
  end
  
  def edit
    @item = Item.find(params[:id])
    @groups = Group.all
  end   

  private

  def item_params
    params.require(:item).permit(:name, :description, :user_id, group_ids: [])
  end
end