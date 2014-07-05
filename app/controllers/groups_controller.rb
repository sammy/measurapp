class GroupsController < ApplicationController

  before_action :check_session

  def index
    @groups = @current_user.groups
  end

  def new
    @group = Group.new
  end

  def create
    redirect_to new_group_path
    flash[:success] = "Group #{group.name} was successfully created!"
  end

end