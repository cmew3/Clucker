require 'spec_helper'
require_relative 'helpers/session'

feature 'In order to let people know what I am doing as a maker I want to post a message to clcuker' do
	
	let!(:user) { User.create(name: "Joe Bloggs",
							email: "test@test.com",
							user_name: "tester",
							password: "password",
							password_confirmation: "password")	
							}

	scenario 'when logged in' do
		sign_in("tester","password")
		click_link "New cluck!"
		add_cluck("My first cluck")
		expect(page).to have_content("My first cluck")
	end

	def add_cluck message
		fill_in :new_cluck, :with => message
		click_button "Cluck!"
	end

end	