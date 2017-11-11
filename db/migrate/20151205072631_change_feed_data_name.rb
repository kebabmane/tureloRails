class ChangeFeedDataName < ActiveRecord::Migration[4.2]
  def change
    rename_column :feeds, :feed_entries, :number_feed_entries
  end
end
