class AddSexToUser < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :is_female, :boolean
  end
end
