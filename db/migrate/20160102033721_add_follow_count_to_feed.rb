class AddFollowCountToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :followees_count, :integer, :default => 0
  end
end
