require 'rails_helper'

RSpec.feature "Sign In", type: :feature do
	scenario " with Facebook" do
		visit root_path
		expect(page).to have_css('a', text: 'SIGN IN')
		click_link 'SIGN IN'
		expect(page.current_path).to eq signin_path
		click_link 'Continue with Facebook'
		expect(page.current_path).to eq user_path
	end
end