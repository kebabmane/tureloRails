class AddDescToFeed < ActiveRecord::Migration[4.2]
  def change
    add_column :feeds, :description, :string
    add_column :feeds, :favicon_url, :string
  end
end
