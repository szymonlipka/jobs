class JobsController < ApplicationController

  def create
    @job = Job.new(job_params)
    if @job.save
      flash[:notice] = 'Job created'
      redirect_to root_path
    else
      flash[:danger] = 'Something went wrong try again'
      redirect_to root_path
    end
  end

  private
  def job_params
    params.require(:job).permit(:name, :id_char, :more_important_jobs)
  end

end