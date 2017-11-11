class AddMoreDetailToCategories < ActiveRecord::Migration[4.2]
  def change
    add_column :categories, :category_image_url, :string
    add_column :categories, :category_description, :string
    add_column :categories, :feeds_count, :integer
  end
end
