class CreateReviews < ActiveRecord::Migration
  def change
    create_table :reviews do |t|
      t.integer :user_id
      t.integer :company_id
      t.text :content
      t.text :pros
      t.text :cons

      t.timestamps null: false
    end
  end
end
