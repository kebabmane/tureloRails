class AddMoreDetailToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :last_fetched, :timestamp
    add_column :feeds, :status, :integer
  end
end
