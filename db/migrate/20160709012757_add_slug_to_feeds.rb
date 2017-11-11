class AddSlugToFeeds < ActiveRecord::Migration[4.2]
  def change
    add_column :feeds, :slug, :string
    add_index :feeds, :slug
  end
end
