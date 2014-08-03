require 'spec_helper'

describe Tag do

	it 'is unique' do
		Tag.create(text: "greeting")
		Tag.create(text: "greeting")
		expect(Tag.count).to eq 1
	end

	it 'can be attached to more than one cluck' do
		Cluck.create(text: "Howdy", tags: [Tag.first_or_create(text: "greeting")])
		Cluck.create(text: "Bonjour", tags: [Tag.first_or_create(text: "greeting")])
		expect(Tag.first.clucks.count).to eq 2
	end
	
end