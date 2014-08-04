require 'spec_helper'

feature 'viewing clucks' do

	let(:user) 		{ User.create(name: "Mr Test",
								  email: "test3@test.com",
								  user_name: "tester3",
								  password: "test",
								  password_confirmation: "test")}
	# let!(:cluck)     { Cluck.create(text: "Hello chickens", user: user)}
	# let!(:cluck2)	{ Cluck.create(text: "Half way through Makers now....eeeeek!",
								   # tags: [Tag.first_or_create(:text => 'makers')],
								   # user: user)}
	
	scenario 'when viewing the homepage' do
		Cluck.create(text: "Hello chickens", user: user)
		visit '/'
		expect(page).to have_content("Hello chickens")
	end

	scenario 'when searching by tag' do
		Cluck.create(text: "Hello chickens", user: user)
		Cluck.create(text: "Half way through Makers now....eeeeek!", tags: [Tag.first_or_create(:text => 'makers')], user: user)	
		visit '/tags/makers'
		expect(page).not_to have_content("Hello chickens")
		expect(page).to have_content("Half way through Makers")
	end

end