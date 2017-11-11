class AddSanitizedFeedEntryData < ActiveRecord::Migration[4.2]
  def change
    add_column :feed_entries, :summary_sanitized, :text
    add_column :feed_entries, :feed_entry_content_sanitized, :text
  end
end
