class AddSocialFinishTag < ActiveRecord::Migration
  def change
    add_column :users, :social_signup_done, :boolean
  end
end
