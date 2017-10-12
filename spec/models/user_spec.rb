require 'rails_helper'

RSpec.describe User, type: :model do
  context "validations" do
  	describe "validates name and email" do
  		it { is_expected.to validate_presence_of(:name) }
  		it { is_expected.to validate_presence_of(:email) }
  		it { is_expected.to validate_uniqueness_of(:email) }
	  	# it { should validate_presence_of :name }
	  	# it { should validate_presence_of :email }
	  	# it { should validate_uniqueness_of(:email) }
	  end

	  describe "validates password" do
  		it { is_expected.to validate_presence_of(:password) }
  		it { is_expected.to validate_presence_of(:password_confirmation) }
	  	# it { should validate_presence_of :password }
	  	# it { should validate_presence_of :password_confirmation }
      it { is_expected.to validate_length_of(:password).is_equal_to(8) }
  		it { is_expected.to validate_confirmation_of(:password) }
	  end

	  describe "validates attributes" do
		  # happy path
	  	it "can be created when all attributes are present" do
		  	let(:user) { User.new(name: "David Lim", email: "david_lim@na.com", password: "12345678", password_confirmation: "12345678") }
		  	expect(user.save).to eq(true)
		  end

		  # unhappy path
		  it "cannot be created without a name" do
		  	let(:user) { User.new(email: "david_lim@na.com", password: "12345678", password_confirmation: "12345678") }
		  	expect(user.save).to eq(false)
		  end

		  it "cannot be created without a email" do
		  	let(:user) { User.new(name: "David Lim", password: "12345678", password_confirmation: "12345678") }
		  	expect(user.save).to eq(false)
		  end

		  it "cannot be created without a password" do
		  	let(:user) { User.new(name: "David Lim", email: "david_lim@na.com") }
		  	expect(user.save).to eq(false)
		  end

		  it "cannot be created without a valid email" do
		  	let(:user) { User.new(name: "David Lim", email: "david_lim.com", password: "12345678", password_confirmation: "12345678") }
		  	expect(user.save).to eq(false)
		  end
	  end
  end

  context "associations with dependency" do
  	it { is_expected.to have_many(:investments).dependent(:destroy)}
    it { is_expected.to have_many(:comments).dependent(:destroy)}
  end
end
