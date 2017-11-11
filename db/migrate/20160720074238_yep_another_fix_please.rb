class YepAnotherFixPlease < ActiveRecord::Migration[4.2]
  def change
    rename_column :categories, :category, :category_name #-- only for production
  end
end
