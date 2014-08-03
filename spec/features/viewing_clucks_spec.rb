require 'spec_helper'

feature 'viewing clucks' do

	before(:each) { Cluck.create(text: "Hello chickens")
					Cluck.create(text: "Half way through Makers now....eeeeek!",
								 tags: [Tag.first_or_create(:text => 'makers')])
								}
	
	scenario 'when viewing the homepage' do
		visit '/'
		expect(page).to have_content("Hello chickens")
	end

	scenario 'when searching by tag' do
		visit '/tags/makers'
		expect(page).not_to have_content("Hello chickens")
		expect(page).to have_content("Half way through Makers")
	end
	
end