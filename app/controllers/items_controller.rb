class ItemsController < ApplicationController

  before_filter :check_session

  def index
    @items = @current_user.items
  end

  def show
    @item = @current_user.items.find_by(slug: params[:id])
    if @item.nil?
      flash[:info] = 'Item does not exist!'
      redirect_to items_path
    end
  end
  
  def new
    @item = Item.new
    @groups = @current_user.groups
  end

  def create
    @item = Item.new(item_params.merge(user_id: @current_user.id))
    if @item.save
      flash[:success] = "Item #{@item.name.upcase} has been succesfully created"
      redirect_to new_item_path
    else
      flash[:error] = @item.errors.full_messages
      render :new
    end
  end
  
  def edit
    if @current_user
      @item = Item.find_by(slug: params[:id])
      @groups = Group.all
    else
      redirect_to root_path
      flash[:alert] = 'Not authorized! You must sign in first.'
    end
  end

  def update
    @item = Item.find_by(slug: params[:id])
    @item.update_attributes(name: params[:item][:name], description: params[:item][:description], group_ids: params[:item][:group_ids])
    flash[:success] = "Item successfully updated."
    redirect_to item_path(@item)
  end

  private

  def item_params
    params.require(:item).permit(:name, :description, :user_id, group_ids: [])
  end
end