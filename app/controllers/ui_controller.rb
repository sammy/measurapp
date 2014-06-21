class UiController < ApplicationController

  before_action :set_session, :except => [:login]


  private

  def set_session
    @session = 1
  end

end