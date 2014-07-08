class GroupsController < ApplicationController

  before_action :check_session

  def index
    @groups = @current_user.groups
  end

  def new
    @group = Group.new
    @items = @current_user.items
  end

  def create
    @group = Group.new(group_params.merge(user_id: @current_user.id))
    if @group.save
      redirect_to new_group_path
      flash[:success] = "Group #{@group.name} was successfully created!"
    else
      flash[:alert] = @group.errors.full_messages
      redirect_to new_group_path
    end
  end

  def edit
    @group = @current_user.groups.find_by(slug: params[:id])
    @items = @current_user.items
  end

  def update
    @group = @current_user.groups.find_by(slug: params[:id])
    @group.update_attributes( name:         params[:group][:name], 
                              description:  params[:group][:description],
                              item_ids:     params[:group][:item_ids] 
                              )
    redirect_to group_path(@group)
    flash[:success] = "Group #{@group.name.upcase} was successfully updated."
  end

  def destroy
    user = User.find(session[:user])
    @group = user.groups.find_by(slug: params[:id])
    if @group
      @group.destroy
      flash[:success] = "Group #{@group.name.upcase} has been successfully deleted."
    else
      flash[:alert] = "Something went wrong!"
    end
      redirect_to groups_path
  end

  private

  def group_params
    params.require(:group).permit!
  end

end