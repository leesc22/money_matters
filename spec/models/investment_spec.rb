require 'rails_helper'

RSpec.describe Investment, type: :model do
	let(:initial_amount)       { 1000 }
	let(:interest_rate)        { 6 }
	let(:interest_rate_period) { 'yearly'}
	let(:period)               { 10 }
	let(:period_type)          { 'years' }
	let(:regular_amount)       { 200 }
	let(:regular_period)       { 'monthly' }
	let(:compounding_period)   { 'yearly' }

  context "validations" do
  	describe "validates interest_rate and period" do
  		it { is_expected.to validate_presence_of(:interest_rate) }
  		it { is_expected.to validate_presence_of(:period) }

  		it "validates interest_rate to be a number" do
	  		expect(:interest_rate).to be_kind_of(Numeric)
  		end
	  end

	  describe "validates attributes" do
		  # happy path
		  it "can be created when all attributes are present" do
		  	let(:investment) { Investment.new(initial_amount: initial_amount, interest_rate: interest_rate, interest_rate_period: interest_rate_period, period: period, period_type: period_type, regular_amount: regular_amount, regular_period: regular_period, compounding_period: compounding_period) }
		  	expect(investment.save).to eq(true)
		  end

		  # unhappy path
		  it "cannot be created without an interest_rate " do
		  	let(:investment) { Investment.new(initial_amount: initial_amount, interest_rate_period: interest_rate_period, period: period, period_type: period_type, regular_amount: regular_amount, regular_period: regular_period, compounding_period: compounding_period) }
		  	expect(investment.save).to eq(false)
		  end

		  it "cannot be created without a period " do
		  	let(:investment) { Investment.new(initial_amount: initial_amount, interest_rate: interest_rate, interest_rate_period: interest_rate_period, period_type: period_type, regular_amount: regular_amount, regular_period: regular_period, compounding_period: compounding_period) }
		  	expect(investment.save).to eq(false)
		  end
		end
  end

  context "self.calculate_future_value" do
  	it "takes in eight attributes" do
  		expect { Investment.calculate_future_value(initial_amount, interest_rate, interest_rate_period, period, period_type, regular_amount, regular_period, compounding_period) }.not_to raise_error
  	end
  end
end
