require 'spec_helper'
require_relative 'helpers/session'

feature 'In order to avoid others to use my account as a maker I want to log out' do

	let!(:user) { User.create(name: "Joe Bloggs",
							email: "test@test.com",
							user_name: "tester",
							password: "password",
							password_confirmation: "password")	
							}

	scenario 'when already signed in' do
		sign_in("tester","password")
		click_button "Sign out"
		expect(page).to have_content("Goodbye")
		expect(page).not_to have_content("Welcome")
	end

end