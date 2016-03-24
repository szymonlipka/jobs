class PagesController < ApplicationController

  def home
    @jobs = Job.all
  end

  def sort_jobs
    @string = Job.order_by_dependencies(sort_params[:string])
    @jobs = Job.all
    render 'home'
  end

  private
  def sort_params
    params.require(:sort_jobs).permit(:string)
  end

end
