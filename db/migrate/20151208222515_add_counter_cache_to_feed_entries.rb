class AddCounterCacheToFeedEntries < ActiveRecord::Migration
  def change
    add_column  :feeds, :feed_entries_count, :integer
  end
end
