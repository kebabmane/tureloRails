json.user @user do
  json.id    		  	@user.id
  json.email	     	@user.email
  json.nickname			@user.nickname
  json.first_name		@user.first_name
  json.last_name		@user.last_name
  json.avatar   		@user.avatar
end
