class PagesController < ApplicationController

  def home
    @jobs = Job.paginate(:page => params[:page], :per_page => 20)
    @job = Job.new
  end

  def sort_jobs
    @string = Job.order_by_dependencies(sort_params[:string])
    @jobs = Job.paginate(:page => params[:page], :per_page => 20)
    @job = Job.new
    render 'home'
  end

  private
  def sort_params
    params.require(:sort_jobs).permit(:string)
  end

end
