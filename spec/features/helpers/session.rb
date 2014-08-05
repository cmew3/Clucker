def sign_up(name = "Joe Bloggs",
			email = 'test@test.com', 
			user_name = 'tester',
			password = 'password',
			password_confirmation = 'password')
	visit '/users/new'
	fill_in :name, :with => name
	fill_in :email, :with => email
	fill_in :user_name, :with => user_name
	fill_in :password, :with => password
	fill_in :password_confirmation, :with => password_confirmation
	click_button "Start Clucking"
end

def sign_in(user_name,password)
	visit '/sessions/new'
	fill_in :user_name, :with => user_name
	fill_in :password, :with => password
	click_button 'Sign in'
end

def fill_in_email(email)
	visit '/users/reset_password'
	fill_in 'email', :with => email
	click_button 'Reset password'
end

def fill_in_new_password(password, password_confirmation)
	fill_in :password, :with => password
	fill_in :password_confirmation, :with => password_confirmation
	click_button "Submit password"
end
