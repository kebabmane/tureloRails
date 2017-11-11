class AddCountToStuff < ActiveRecord::Migration[4.2]
  def change
    add_column :feeds, :followers_count, :integer, :default => 0
    add_column :feed_entries, :likees_count, :integer, :default => 0
  end
end
