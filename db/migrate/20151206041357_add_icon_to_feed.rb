class AddIconToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :feed_icon, :string
  end
end
