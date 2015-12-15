class AddCountToStuff < ActiveRecord::Migration
  def change
    add_column :feeds, :followers_count, :integer, :default => 0
    add_column :feed_entries, :likees_count, :integer, :default => 0
  end
end
