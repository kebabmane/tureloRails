class YepAnotherFixPlease < ActiveRecord::Migration
  def change
    rename_column :categories, :category, :category_name #-- only for production
  end
end
