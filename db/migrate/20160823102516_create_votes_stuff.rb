class CreateVotesStuff < ActiveRecord::Migration
  def change
      add_column :feed_entries, :disabled, :boolean
      add_column :feed_entries, :comments_count, :integer, :null => false, :default => 0
      add_column :feed_entries, :upvotes_count, :integer, :null => false, :default => 0
      add_column :feed_entries, :downvotes_count, :integer, :null => false, :default => 0
      add_column :feed_entries, :score, :integer, :null => false, :default => 0
      add_column :feed_entries, :rank, :integer, :null => false, :default => 0
  end
end
