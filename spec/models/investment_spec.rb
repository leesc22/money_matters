require 'rails_helper'

RSpec.describe Investment, type: :model do
  context "validations" do
  	describe "validates interest_rate and period" do
  		it { is_expected.to validate_presence_of(:interest_rate) }
  		it { is_expected.to validate_presence_of(:period) }
  		expect(:interest_rate).to be_kind_of Numeric
	  end

	  # happy path
	  describe "can be created when all attributes are present" do
	  	let(:user) { User.new(name: "David Lim", email: "david_lim@na.com", password: "12345678", password_confirmation: "12345678") }
	  	expect(user.save).to eq(true)
	  end

	  # unhappy path
	  describe "cannot be created without a name" do
	  	let(:user) { User.new(email: "david_lim@na.com", password: "12345678", password_confirmation: "12345678") }
	  	expect(user.save).to eq(false)
	  end

  end
end
