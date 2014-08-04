require 'spec_helper'
require_relative 'helpers/session'

feature 'In order to use clucker I want to sign up to the service' do

	scenario 'when logged out' do
		sign_up
		expect(page).to have_content("Welcome, tester")
		expect(User.first.email).to eq("test@test.com")
	end

	scenario 'with a password that does not match' do
		sign_up('Sarah Bloggs', 'test2@test.com','tester2','password','wrongpassword')
		expect(current_path).to eq('/users')
		expect(page).to have_content("passwords do not match")
	end

	scenario 'with an email that is already registered' do
		sign_up
		sign_up('Sarah Bloggs', 'test@test.com','tester2','password','password')
		expect(page).to have_content("Email is already registered")
	end

	scenario 'with a user_name that is already registered' do
		sign_up
		sign_up('Sarah Bloggs', 'test2@test.com','tester','password','password')
		expect(page).to have_content("Username has already been taken")
	end

end
