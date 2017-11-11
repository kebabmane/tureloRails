class AddMoreDetailToEntries < ActiveRecord::Migration[4.2]
  def change
    add_column :feed_entries, :is_read, :boolean
    add_column :feed_entries, :keep_unread, :boolean
    add_column :feed_entries, :is_starred, :boolean
    add_column :feed_entries, :entry_id, :text
  end
end
