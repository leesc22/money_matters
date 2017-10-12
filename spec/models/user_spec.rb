require 'rails_helper'

RSpec.describe User, type: :model do
	let(:valid_user) { User.new(name: "David Lim", email: "david_lim@na.com", password: "12345678", password_confirmation: "12345678") }
	let(:missing_user_name) { User.new(email: "david_lim@na.com", password: "12345678", password_confirmation: "12345678") }
	let(:missing_user_email) { User.new(name: "David Lim", password: "12345678", password_confirmation: "12345678") }
	let(:missing_user_password) { User.new(name: "David Lim", email: "david_lim@na.com") }
	let(:invalid_user_email) { User.new(name: "David Lim", email: "david_lim.com", password: "12345678", password_confirmation: "12345678") }

	
  context "validations" do
	  describe "validates attributes" do
		  # happy path
	  	it "can be created when all attributes are present" do
		  	expect(valid_user.save).to eq(true)
		  end

		  # unhappy path
	  	before do
	  	end
		  it "cannot be created without a name" do
		  	expect(missing_user_name.save).to eq(false)
		  end

		  it "cannot be created without a email" do
		  	expect(missing_user_email.save).to eq(false)
		  end

		  it "cannot be created without a password" do
		  	expect(missing_user_password.save).to eq(false)
		  end

		  it "cannot be created without a valid email" do
		  	expect(invalid_user_email.save).to eq(false)
		  end
	  end
  end

  context "associations with dependency" do
  	it { is_expected.to have_many(:investments).dependent(:destroy)}
    it { is_expected.to have_many(:comments).dependent(:destroy)}
  end
end
