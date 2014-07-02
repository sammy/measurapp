class ItemsController < ApplicationController

  before_filter :check_session
  
  def new
    @item = Item.new
  end
  
end