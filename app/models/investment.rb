FREQUENCY = { 'Yearly': 1, 'Half Yearly': 2, 'Quarterly': 4, 'Monthly': 12 }
PERIOD = { 'Years': 1, 'Months': 12 }

class Investment < ApplicationRecord
	belongs_to :user, optional: true
	validates :period, presence: true
	before_save :calculate_future_value

	def calculate_future_value
		regular_period = FREQUENCY[self.regular_period.to_sym]
		period_type = PERIOD[self.period_type.to_sym]
		
		self.future_value = calculate_initial_amount_future_value(self) + calculate_regular_amount_future_value(self)
		total_investment = self.initial_amount + self.regular_amount * regular_period * period * period_type
		self.total_interest = self.future_value - total_investment
	end

	def calculate_initial_amount_future_value(obj)
		obj.initial_amount * (1 + obj.interest_rate.to_f / 100)**(obj.period)
	end

	def calculate_regular_amount_future_value(obj)
		regular_period = FREQUENCY[obj.regular_period.to_sym]
		regular_amount = obj.regular_amount || 0
		interest_rate = obj.interest_rate || 0
		
		regular_amount * ((1 + (interest_rate.to_f / 100) / regular_period )**(obj.period * regular_period) - 1) / (interest_rate.to_f / 100 / regular_period)
	end
end
