class AddSanitizedFeedEntryData < ActiveRecord::Migration
  def change
    add_column :feed_entries, :summary_sanitized, :text
    add_column :feed_entries, :feed_entry_content_sanitized, :text
  end
end
