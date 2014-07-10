class MeasuresController < ApplicationController

  before_filter :check_session

  def index
    @measures = @current_user.measures
  end
  
  def new
    @measure = Measure.new
  end

  def create
    @measure = Measure.new(measure_params.merge(user_id: @current_user.id))
    if @measure.save
      flash[:success] = "Measure #{@measure.name.upcase} successfully created"
      redirect_to new_measure_path
    elsif @measure.errors
      flash[:alert] = @measure.errors.full_messages.join("<br>").html_safe
      render :new
    end
  end
  
  
  private

  def measure_params
    params.require(:measure).permit(:name, :description, :min_value, :max_value)
  end
end