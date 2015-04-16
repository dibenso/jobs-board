class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :name
      t.float :min_wage
      t.float :max_wage
      t.string :time
      t.string :location

      t.timestamps null: false
    end
  end
end
