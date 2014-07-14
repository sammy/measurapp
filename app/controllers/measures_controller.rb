class MeasuresController < ApplicationController

  before_filter :check_session

  def index
    @measures = @current_user.measures
  end
  
  def new
    @measure = Measure.new
    @groups = @current_user.groups
  end

  def create
    binding.pry
    @measure = Measure.new(measure_params.merge(user_id: @current_user.id))
    if @measure.save
      @measure.groups = params[:measure][:groups]
      flash[:success] = "Measure #{@measure.name.upcase} successfully created"
      redirect_to new_measure_path
    elsif @measure.errors
      flash[:alert] = @measure.errors.full_messages.join("<br>").html_safe
      render :new
    end
  end

  def show
    @measure = @current_user.measures.find_by(slug: params[:id])
    if @measure.nil? 
      flash[:alert] = "Measure not found!"
      redirect_to home_path
    end
  end

  def destroy
    @measure = @current_user.measures.find_by(slug: params[:id])
    if @measure
      @measure.destroy
      flash[:success] = "Measure #{@measure.name.upcase} has been successfully deleted" 
    else
      flash[:alert] = 'Measure not found'
    end
    redirect_to measures_path
  end
  
  
  private

  def measure_params
    params.require(:measure).permit(:name, :description, :min_value, :max_value, :groups)
  end
end