class ChangeFeedDataName < ActiveRecord::Migration
  def change
    rename_column :feeds, :feed_entries, :number_feed_entries
  end
end
