class AddCounterCacheToFeedEntryImages < ActiveRecord::Migration
  def change
    add_column :feed_entries, :feed_entry_images_count, :integer, :default => 0
    add_index :feed_entries, :feed_entry_images_count
  end
end
