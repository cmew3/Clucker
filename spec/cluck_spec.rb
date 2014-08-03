require 'spec_helper'

describe Cluck  do

	context 'when being saved and retrieved from the database' do

		it 'has text and a time which is saved to the database' do
			Cluck.create(text: "Some text", time: Time.now)
			cluck = Cluck.first
			expect(cluck.text).to eq "Some text"
			expect(cluck.time).to be_instance_of(Time)
			expect(Cluck.count).to eq 1
		end

		it 'will only accept text 140 characters long' do
			long_message="-"*150
			Cluck.create(text: long_message, time: Time.now)
			expect(Cluck.count).to eq 0
		end

		it 'is has a mood which is neutral as default' do
			Cluck.create(text: "Some text", time: Time.now)
			cluck = Cluck.first
			expect(cluck.mood).to eq "neutral"
			Cluck.create(text: "This test better pass!", time: Time.now, mood: "angry")
			cluck = Cluck.last
			expect(cluck.mood).to eq "angry"
			puts Cluck.all.inspect
		end

		it 'can have tags' do
			Cluck.create(text: "Some text", time: Time.now, tags: [Tag.create(text: "greeting")])
			expect(Cluck.first.tags.first.text).to eq "greeting"
		end

	end
end