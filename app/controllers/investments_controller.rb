class InvestmentsController < ApplicationController
	def index
		@investments = Investment.all
	end

	def show
		@investment = Investment.find(params[:id])
	end

	def new
		@investment = Investment.new
	end

	def create
		@investment = Investment.new(investment_params)

		if @investment.save
			flash[:success] = "Investment is created successfully."
			redirect_to @investment
		else
			flash[:danger] = "Error calculating."
			render 'new'
		end
	end

	def destroy
		@investment = Investment.find(params[:id])
		@investment.destroy
		
		redirect_back(fallback_location: root_path)
	end

	private

	def investment_params
		params.require(:investment).permit(:initial_amount, :interest_rate, :interest_rate_period, :period, :period_type, :regular_amount, :regular_period, :compounding_period)
	end
end
