require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:article) { user.articles.new(title: 'Title', content: 'Content') }

  context "validations" do
	  describe "do not have validations" do
		  # happy path
		  it "article can be created" do
		  	expect(article.save).to eq(true)
		  end
		end
	end
end
