class AddMoreImportantJobsToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :more_important_jobs, :string
    add_index :jobs, :more_important_jobs
  end
end
