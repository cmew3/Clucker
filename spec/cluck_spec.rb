require 'spec_helper'

describe Cluck  do

	context 'when being saved and retrieved from the database' do

		let(:user)  {User.create(name: "Joe Bloggs",
					email: "test@test.com",
					user_name: "tester",
					password: "test",
					password_confirmation: "test")}

		it 'has text and a time which is saved to the database' do
			Cluck.create(text: "Some text", time: Time.now, user: user)
			cluck = Cluck.first
			expect(cluck.text).to eq "Some text"
			expect(cluck.time).to be_instance_of(Time)
			expect(Cluck.count).to eq 1
		end

		it 'will only accept text 140 characters long' do
			long_message="-"*150
			Cluck.create(text: long_message, time: Time.now, user: user)
			expect(Cluck.count).to eq 0
		end

		it 'is has a mood which is neutral as default' do
			Cluck.create(text: "Some text", time: Time.now, user: user)
			cluck = Cluck.first
			expect(cluck.mood).to eq "neutral"
			Cluck.create(text: "This test better pass!", time: Time.now, mood: "angry", user: user)
			cluck = Cluck.last
			expect(cluck.mood).to eq "angry"
		end

		it 'can have tags' do
			Cluck.create(text: "Some text", time: Time.now, tags: [Tag.create(text: "greeting")], user: user)
			expect(Cluck.first.tags.first.text).to eq "greeting"
		end

	end
end