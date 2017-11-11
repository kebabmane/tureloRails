class AddDeletedAtToFeeds < ActiveRecord::Migration[4.2]
  def change
    add_column :feeds, :deleted_at, :datetime
    add_index :feeds, :deleted_at
  end
end
