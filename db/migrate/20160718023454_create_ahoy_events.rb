class CreateAhoyEvents < ActiveRecord::Migration
  def change
    drop_table :ahoy_events
    create_table :ahoy_events do |t|
      t.integer :visit_id

      # user
      t.integer :user_id
      t.string :user_type

      t.string :name
      t.jsonb :properties
      t.timestamp :time
    end

    add_index :ahoy_events, [:visit_id, :name]
    add_index :ahoy_events, [:user_id, :name]
    add_index :ahoy_events, [:name, :time]
  end
end
