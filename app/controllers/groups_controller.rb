class GroupsController < ApplicationController

  before_action :check_session

  def index
    @groups = @current_user.groups
  end

end