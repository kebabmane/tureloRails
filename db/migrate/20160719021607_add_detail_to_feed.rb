class AddDetailToFeed < ActiveRecord::Migration[4.2]
  def change
    add_column :feeds, :feed_description, :string
    add_column :feeds, :feed_image_url, :string
    add_column :feeds, :category_id, :integer
  end
end
