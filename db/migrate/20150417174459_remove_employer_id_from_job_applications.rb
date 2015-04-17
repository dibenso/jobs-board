class RemoveEmployerIdFromJobApplications < ActiveRecord::Migration
  def change
    remove_column :job_applications, :employer_id
  end
end
