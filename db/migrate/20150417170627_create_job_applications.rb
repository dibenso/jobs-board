class CreateJobApplications < ActiveRecord::Migration
  def change
    create_table :job_applications do |t|
      t.integer :job_id
      t.integer :user_id
      t.integer :employer_id
      t.string :first_name
      t.string :last_name
      t.text :cover_letter

      t.timestamps null: false
    end
  end
end
