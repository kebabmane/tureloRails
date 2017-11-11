class AddMoreDetailToFeed < ActiveRecord::Migration[4.2]
  def change
    add_column :feeds, :last_fetched, :timestamp
    add_column :feeds, :status, :integer
  end
end
