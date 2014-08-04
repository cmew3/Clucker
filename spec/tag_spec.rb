require 'spec_helper'

describe Tag do

	let(:user)  {User.create(name: "Joe Bloggs",
					email: "test@test.com",
					user_name: "tester",
					password: "test",
					password_confirmation: "test")}

	it 'is unique' do
		Tag.create(text: "greeting")
		Tag.create(text: "greeting")
		expect(Tag.count).to eq 1
	end

	it 'can be attached to more than one cluck' do
		Cluck.create(text: "Howdy", tags: [Tag.first_or_create(text: "greeting")], user: user)
		Cluck.create(text: "Bonjour", tags: [Tag.first_or_create(text: "greeting")], user: user)
		expect(Tag.first.clucks.count).to eq 2
	end
	
end	