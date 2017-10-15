require 'rails_helper'

RSpec.describe Investment, type: :model do
	let(:initial_amount)       { 1000 }
	let(:interest_rate)        { 6 }
	let(:interest_rate_period) { 'Yearly'}
	let(:period)               { 10 }
	let(:period_type)          { 'Years' }
	let(:regular_amount)       { 200 }
	let(:regular_period)       { 'Monthly' }
	let(:compounding_period)   { 'Yearly' }
	let(:valid_investment) { Investment.new(initial_amount: initial_amount, interest_rate: interest_rate, interest_rate_period: interest_rate_period, period: period, period_type: period_type, regular_amount: regular_amount, regular_period: regular_period, compounding_period: compounding_period) }
	let(:missing_interest_rate) { Investment.new(initial_amount: initial_amount, interest_rate_period: interest_rate_period, period: period, period_type: period_type, regular_amount: regular_amount, regular_period: regular_period, compounding_period: compounding_period) }
	let(:missing_period) { Investment.new(initial_amount: initial_amount, interest_rate: interest_rate, interest_rate_period: interest_rate_period, period_type: period_type, regular_amount: regular_amount, regular_period: regular_period, compounding_period: compounding_period) }

  context "validations" do
	  describe "validates attributes" do
		  # happy path
		  it "can be created when all attributes are present" do
		  	expect(valid_investment.save).to eq(true)
		  end

		  # unhappy path
		  it "cannot be created without an interest_rate " do
		  	missing_interest_rate.interest_rate = nil
		  	expect(missing_interest_rate.save).to eq(false)
		  end

		  it "cannot be created without a period " do
		  	expect(missing_period.save).to eq(false)
		  end
		end
  end

  # custom method
  context "self.calculate_future_value" do
  	it "to not raise error" do
  		expect { valid_investment.calculate_future_value }.not_to raise_error
  	end
  end
end
