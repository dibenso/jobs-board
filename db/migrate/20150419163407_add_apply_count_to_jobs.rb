class AddApplyCountToJobs < ActiveRecord::Migration
  def change
    add_column :jobs, :apply_count, :integer
  end
end
