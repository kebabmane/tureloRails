class AddDetailToUsers < ActiveRecord::Migration
  def change
    add_column :users, :date_of_birth, :date
    add_column :users, :home_page, :string
    add_column :users, :user_description, :text
    add_column :users, :first_name, :string
    add_column :users, :last_name, :string
    add_column :users, :nickname, :string, :unique => true
  end
end
