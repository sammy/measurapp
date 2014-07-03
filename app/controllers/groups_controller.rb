class GroupsController < ApplicationController

  before_action :check_session

  def index
    @groups = @current_user.groups
  end

  def new
    @group = Group.new
  end

end