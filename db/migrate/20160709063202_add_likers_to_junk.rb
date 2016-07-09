class AddLikersToJunk < ActiveRecord::Migration
  def change
    add_column :feeds, :mentioners_count, :integer, :default => 0
    add_column :feed_entries, :mentioners_count, :integer, :default => 0
    add_column :feeds, :mentionees, :integer, :default => 0
    add_column :feed_entries, :mentionees, :integer, :default => 0
    add_column :feeds, :likers_count, :integer, :default => 0
    add_column :feed_entries, :likers_count, :integer, :default => 0
  end
end
