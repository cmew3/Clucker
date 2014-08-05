require 'spec_helper'
require_relative 'helpers/session'

feature 'In order to let people know what I am doing I want to post a message to clucker' do
	
	let!(:user) { User.create(name: "Joe Bloggs",
							email: "test@test.com",
							user_name: "tester",
							password: "password",
							password_confirmation: "password")	
							}

	scenario 'when logged in' do
		sign_in("tester","password")
		click_link "New cluck!"
		add_new_cluck("My first cluck")
		expect(page).to have_content("My first cluck")
		expect(page).to have_content("Joe Bloggs")
	end

	scenario 'when not logged in' do
		visit '/'
		expect(page).not_to have_content "New cluck!"
	end

	scenario 'when adding tags' do
		sign_in("tester","password")
		click_link "New cluck!"
		add_new_cluck("first cluck with tags",["greeting","tags"])
		expect(page).to have_content "first cluck with tags"
		expect(page).to have_content "greeting"
	end	

	def add_new_cluck message, tags = []
		fill_in :new_cluck, :with => message
		fill_in :tags, :with => tags.join(" ")
		click_button "Cluck!"
	end

end	