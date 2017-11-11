class AddSocialFinishTag < ActiveRecord::Migration[4.2]
  def change
    add_column :users, :social_signup_done, :boolean
  end
end
