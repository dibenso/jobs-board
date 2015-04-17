class AddEmployerIdToJobApplications < ActiveRecord::Migration
  def change
    add_column :job_applications, :employer_id, :integer
  end
end
