class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.belongs_to :user
      t.string :feed_name
      t.string :feed_url
      t.integer :feed_entries

      t.timestamps null: false
    end
  end
end
