class AddDetailForImpressions < ActiveRecord::Migration[4.2]
  def change
    add_column :feeds, :impressions_count, :integer
    add_column :feed_entries, :impressions_count, :integer
  end
end
