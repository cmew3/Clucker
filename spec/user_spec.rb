require 'spec_helper'

describe User do

	xit 'has a valid email address' do
		User.create(name: "Charlotte Kelly",
					email: "notanemail",
					user_name: "cmew3"
					)
		expect(User.count).to eq 0	
	end

	it 'has unique email and username' do
		User.create(name: "Charlotte Kelly",
					email: "test@test.com",
					user_name: "cmew3"
					)
		User.create(name: "Chris Kelly",
					email: "test@test.com",
					user_name: "ck2"
					)
		User.create(name: "Chris Kelly",
					email: "test2@test.com",
					user_name: "cmew3"
					)
		expect(User.count).to eq 1
	end

	
end