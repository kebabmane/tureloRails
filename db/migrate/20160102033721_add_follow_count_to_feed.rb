class AddFollowCountToFeed < ActiveRecord::Migration[4.2]
  def change
    add_column :feeds, :followees_count, :integer, :default => 0
  end
end
