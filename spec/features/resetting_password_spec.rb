require 'spec_helper'
require_relative 'helpers/session'

feature 'requesting a password reset' do

	let!(:user) {User.create(:name => "Sarah Bloggs",
					:user_name => "tester",
					:email => "test@test.com",
					:password => "test",
					:password_confirmation => "test")}

	scenario 'when user has forgotten password' do
		visit '/sessions/new'
		click_link 'Forgotten password'
		expect(page).to have_content("Please enter your email address")
		fill_in_email('test@test.com')
		expect(page).to have_content("A link to reset you password will be sent to your email shortly")
	end

	scenario 'when user has forgotten password but enters an invalid email' do
		visit '/sessions/new'
		click_link 'Forgotten password'
		fill_in_email('invalidemail@test.com')
		expect(page).to have_content("Email not recognised")
	end

end

feature 'setting a new password' do

	let!(:user) {User.create(:email => "test@test.com",
					:user_name => "tester",
					:password => "test",
					:password_confirmation => "test",
					:password_token => "ABCDEFGHIJKLMNO",
					:password_token_timestamp => Time.now-100)}

	scenario 'when user follows the email link and enters valid password' do
		visit '/users/reset_password/ABCDEFGHIJKLMNO'
		expect(page).to have_content("please enter a new password")
		fill_in_new_password("new_password","new_password")
		expect(page).to have_content("Welcome, tester")
	end

	scenario 'when user follows the email link and enters invalid password' do
		visit '/users/reset_password/ABCDEFGHIJKLMNO'
		fill_in_new_password("new_password","bad_password")
		expect(page).to have_content("Ooops")
	end

	scenario 'does not reset the password if token has timed out' do
		user.update(:password_token_timestamp => Time.now-4000)
		visit '/users/reset_password/ABCDEFGHIJKLMNO'
		expect(page).to have_content("your password reset has timed out")
	end

end