class AddPhoneNumberToJobApplications < ActiveRecord::Migration
  def change
    add_column :job_applications, :phone_number, :string
  end
end
