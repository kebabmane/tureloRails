class AddSummaryToFeedEntries < ActiveRecord::Migration[4.2]
  def change
    add_column  :feed_entries, :summary, :text
    change_column :feed_entries, :feed_entry_content,  :text
  end
end
