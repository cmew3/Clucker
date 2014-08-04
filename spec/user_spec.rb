require 'spec_helper'

describe User do

	let!(:user) {User.create(name: "Charlotte Kelly",
					email: "test@test.com",
					user_name: "cmew3",
					password: "test",
					password_confirmation: "test")}

	it 'has a valid email address' do
		User.create(name: "Another User",
					email: "notanemail",
					user_name: "user2",
					password: "test",
					password_confirmation: "test"
					)
		expect(User.count).to eq 1	
	end

	it 'has unique email and username' do
		expect(User.count).to eq 1
		User.create(name: "Chris Kelly",
					email: "test@test.com",
					user_name: "ck2",
					password: "test",
					password_confirmation: "test"
					)
		User.create(name: "Chris Kelly",
					email: "test2@test.com",
					user_name: "cmew3",
					password: "test",
					password_confirmation: "test"
					)
		expect(User.count).to eq 1
	end

	it 'can add clucks' do
		user.add_cluck("My new cluck")
		expect(user.clucks.first.text).to eq "My new cluck"
	end

	
end