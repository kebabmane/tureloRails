class AddDetailForImpressions < ActiveRecord::Migration
  def change
    add_column :feeds, :impressions_count, :integer
    add_column :feed_entries, :impressions_count, :integer
  end
end
