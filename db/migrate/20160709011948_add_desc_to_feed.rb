class AddDescToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :description, :string
    add_column :feeds, :favicon_url, :string
  end
end
