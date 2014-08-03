require 'spec_helper'
require_relative 'helpers/session'

feature 'In order to user clucker as a maker I want to log in' do

	let!(:user) { User.create(name: "Susan Bloggs",
							email: "test@test.com",
							user_name: "tester",
							password: "password",
							password_confirmation: "password")	
							}

	scenario 'with correct information' do
		sign_in("tester", "password")
		expect(page).to have_content("Welcome, tester")
	end

		scenario 'with incorrect information' do
		sign_in("tester", "wrong_pass")
		expect(page).to have_content("Email or password did not match")
	end


end