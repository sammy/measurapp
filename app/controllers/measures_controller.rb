class MeasuresController < ApplicationController

  before_filter :check_session
  
  def new
    @measure = Measure.new
  end
  
end