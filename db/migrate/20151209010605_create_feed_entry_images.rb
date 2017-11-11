class CreateFeedEntryImages < ActiveRecord::Migration[4.2]
  def change
    create_table :feed_entry_images do |t|
      t.belongs_to :feed_entry, index: true, foreign_key: true
      t.string :img_url

      t.timestamps null: false
    end
  end
end
