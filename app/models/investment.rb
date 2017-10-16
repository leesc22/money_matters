FREQUENCY = { 'Yearly': 1, 'Half Yearly': 2, 'Quarterly': 4, 'Monthly': 12 }
PERIOD = { 'Years': 1, 'Months': 12 }

class Investment < ApplicationRecord
	belongs_to :user, optional: true
	validates :initial_amount, :regular_amount, :interest_rate, :period, presence: true
	before_save :calculate_future_value

	def calculate_future_value
		regular_period = FREQUENCY[self.regular_period.to_sym]
		period_type = PERIOD[self.period_type.to_sym]

		self.future_value = calculate_initial_amount_future_value(self) + calculate_regular_amount_future_value(self)
		self.total_investment = self.initial_amount + self.regular_amount * (regular_period * period - 1)
		self.total_interest = self.future_value - self.total_investment
	end

	def calculate_initial_amount_future_value(obj)
		regular_period = FREQUENCY[obj.regular_period.to_sym]

		obj.initial_amount * (1 + (obj.interest_rate.to_f / 100) / regular_period)**(obj.period * regular_period)
	end

	def calculate_regular_amount_future_value(obj)
		regular_period = FREQUENCY[obj.regular_period.to_sym]
		regular_amount = obj.regular_amount
		interest_rate = (obj.interest_rate.to_f / 100) / regular_period
		
		regular_amount * ((1 + interest_rate)**(obj.period * regular_period - 1) - 1) / interest_rate * (1 + interest_rate)
	end

	# PENDING - thinking of ways to calculate other attributes - before_save method is not feasible
	def self.calculate_regular_amount
		# given initial_amount, regular_period, interest_rate, period and future value - find regular_amount
		self.total_investment = self.initial_amount + self.regular_amount * (regular_period * period - 1)
		self.total_interest = self.future_value - self.total_investment
		regular_period = FREQUENCY[obj.regular_period.to_sym]
		interest_rate = (obj.interest_rate.to_f / 100) / regular_period
		self.regular_amount = (self.future_value - (self.initial_amount*(1 + interest_rate)**(period * regular_period))) * (interest_rate / (1 + interest_rate) * ((1 + interest_rate)**(period * regular_period - 1) - 1))
	end
end
