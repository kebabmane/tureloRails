class CreateFeedEntries < ActiveRecord::Migration
  def change
    create_table :feed_entries do |t|
      t.belongs_to :feed, index: true, foreign_key: true
      t.string :title
      t.string :feed_entry_url
      t.datetime :published
      t.string :author
      t.string :feed_entry_content

      t.timestamps null: false
    end
  end
end
