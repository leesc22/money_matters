require 'rails_helper'

RSpec.describe User, type: :model do
	let(:valid_user) { User.new(name: "David Lim", email: "david_lim@na.com", password: "12345678", password_confirmation: "12345678") }
	let(:missing_user_name) { User.new(email: "david@na.com", password: "12345678", password_confirmation: "12345678") }
	let(:missing_user_email) { User.new(name: "David Lim", password: "12345678", password_confirmation: "12345678") }
	let(:missing_user_password) { User.new(name: "David Lim", email: "david_lim@na.com") }
	let(:invalid_user_email_repeat) { User.new(name: "David Lim", email: "david_lim@na.com", password: "12345678", password_confirmation: "12345678") }
	let(:invalid_user_email_format) { User.new(name: "David Lim", email: "david_lim.com", password: "12345678", password_confirmation: "12345678") }
	let(:invalid_user_password_confirmation) { User.new(name: "David Lim", email: "david_lim@na.com", password: "12345678", password_confirmation: "12345679") }
	let(:invalid_user_password_length) { User.new(name: "David Lim", email: "david_lim@na.com", password: "1234567", password_confirmation: "1234567") }
	
  context "validations" do
	  describe "validates attributes" do
		  # happy path
	  	it "can be created when all attributes are present" do
		  	expect(valid_user.save).to eq(true)
		  	user = User.last
		  	expect(user.name).to eq("David Lim")
		  	expect(user.email).to eq("david_lim@na.com")
		  end

		  # unhappy path
		  # test presence of name
		  it "cannot be created without a name" do
		  	expect(missing_user_name.save).to eq(false)
		  end

		  # test presence of email
		  it "cannot be created without a email" do
		  	expect(missing_user_email.save).to eq(false)
		  end

		  # test presence of password
		  it "cannot be created without a password" do
		  	expect(missing_user_password.save).to eq(false)
		  end

		  # test uniqueness of email
		  it "cannot be created without a unique email" do
		  	valid_user.save
		  	expect(invalid_user_email_repeat.save).to eq(false)
		  end

		  # test email format
		  it "cannot be created without a valid email format" do
		  	expect(invalid_user_password_confirmation.save).to eq(false)
		  end

		  # test matching password confirmation
		  it "cannot be created without a valid password confirmation" do
		  	expect(invalid_user_email_format.save).to eq(false)
		  end

		  # test length of password
		  it "cannot be created without a valid password confirmation" do
		  	expect(invalid_user_email_format.password.length).to be(8)
		  	expect(invalid_user_password_length.save).to eq(false)
		  end
	  end
  end

  context "associations with dependency" do
  	it "should have many investments" do
  		investments = User.reflect_on_association(:investments)
  		expect(investments.macro).to eq(:has_many)
  	end

  	it "should have many authentications" do
  		authentications = User.reflect_on_association(:authentications)
  		expect(authentications.macro).to eq(:has_many)
  	end

  	it "should have many articles" do
  		articles = User.reflect_on_association(:articles)
  		expect(articles.macro).to eq(:has_many)
  	end
  end
end
