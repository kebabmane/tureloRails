json.user @user do |user|
  json.(user, :id, :first_name, :last_name, :nickname, :email, :avatar)
end
