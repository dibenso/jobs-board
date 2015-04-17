class AddUsernameToEmployers < ActiveRecord::Migration
  def change
    add_column :employers, :username, :string
  end
end
