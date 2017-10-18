require 'rails_helper'

RSpec.feature "Investment calculator", type: :feature do
	scenario "results and pie chart displayed asynchronously" do
		visit root_path
		expect(page).to have_content "Investment Calculator"
		expect(page).to_not have_content "Results"
		click_button 'Calculate Future Value'
		expect(page).to have_content "Results"
		Nokogiri::HTML.parse(page.body).css('svg')
	end
end