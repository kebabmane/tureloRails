class AddSummaryToFeedEntries < ActiveRecord::Migration
  def change
    add_column  :feed_entries, :summary, :text
    change_column :feed_entries, :feed_entry_content,  :text
  end
end
