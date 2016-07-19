class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :category
      t.integer :feed_id
      t.timestamps null: false
    end
  end
end
