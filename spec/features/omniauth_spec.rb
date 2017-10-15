require 'rails_helper'

OmniAuth.config.test_mode = true
OmniAuth.config.mock_auth[:facebook] = OmniAuth::AuthHash.new({
	provider: 'facebook',
	uid: '12345',
	credentials: {
		token: '123456',
		expires_at: Time.now + 1.week
	},
	extra: {
		raw_info: {
			name: 'David Lim',
			email: 'david_lim@na.com'
		}
	}
})

RSpec.feature "User signin and signout with Facebook", type: :feature do
	scenario "with valid credentials" do
		visit root_path
		expect(page).to have_css('a', text: 'SIGN IN')
		click_link 'SIGN IN'
		click_link 'Continue with Facebook'
		expect(page).to have_content "User created. Please confirm or edit details."
		expect(page).to have_content "Edit Profile"
		click_button 'Save'
		expect(page).to have_content "Updated successfully."
		click_link 'SIGN OUT'
		expect(page.current_path).to eq sign_in_path
	end
end

