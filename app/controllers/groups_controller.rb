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
    @group.save
    redirect_to new_group_path
    flash[:success] = "Group #{@group.name} was successfully created!"
  end

  private

  def group_params
    params.require(:group).permit!
  end

end