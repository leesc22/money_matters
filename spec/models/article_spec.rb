require 'rails_helper'

RSpec.describe Article, type: :model do
  let(:user) { FactoryGirl.create(:user) }
  let(:article) { user.articles.new(title: 'Importance of Savings', content: 'Buffer for emergency funds') }

  context "validations" do
	  describe "do not have validations" do
		  # happy path
		  it "article can be created" do
		  	expect(article.save).to eq(true)
		  end
		end
	end

	# custom method
  context "self.search()" do
  	it "finds a searched articles by title " do
  		article.save
  		expect(Article.search('savings').first).to eq(article)
  		expect(Article.search('savings').first.title).to eq(article.title)
  	end
  end
end
