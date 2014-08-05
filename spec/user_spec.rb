require 'spec_helper'

describe User do

	let!(:user) {User.create(name: "Charlotte Kelly",
					email: "test@test.com",
					user_name: "cmew3",
					password: "test",
					password_confirmation: "test")}
	context 'when created' do


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

	end

	context 'when using clucker' do
		it 'can add clucks' do
			user.add_cluck("My new cluck")
			expect(user.clucks.first.text).to eq "My new cluck"
		end

	end

	context 'when forgetting a password' do
			it 'can reset a password when given a password hash' do 
		user = User.create(:email => "test2@test.com",
					:password => "test2",
					:user_name => "tester",
					:password_confirmation => "test2",  
					:password_token => "ABCDEFGHIJKLMNO",
					:password_token_timestamp => Time.now-60)
		digest = user.password_digest
		user.reset_password("newpass","newpass")
		user = reload(user)
		expect(user.password_token).to be nil
		expect(user.password_token_timestamp).to be nil
		expect(user.password_digest).not_to eq digest
	end


	it 'does not reset a password if validations fail' do 
		user = User.create(:email => "test5@test.com",
					:user_name => "tester",
					:password => "test2",	
					:password_confirmation => "test2",  
					:password_token => "ABCDEFGHIJKLMNO",
					:password_token_timestamp => Time.now-60)
		digest = user.password_digest
		user.reset_password("newpass","wrongconfirm")
		user = reload(user)
		expect(user.password_token).not_to be nil
		expect(user.password_token_timestamp).not_to be nil
		expect(user.password_digest).to eq digest
	end

	end
end