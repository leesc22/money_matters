class InvestmentsController < ApplicationController

	def index
		@investments = current_user.investments
	end

	def show
		@investment = Investment.find(params[:id])
	end

	def new
		@investment = Investment.new
	end

	def create
		if current_user
			@investment = current_user.investments.new(investment_params)
		else
			@investment = Investment.new(investment_params)
		end

		if @investment.save
			respond_to do |format|
	      format.html { redirect_to @investment, flash: { success: "Investment is created successfully." } }
	      format.js
	    end
		else
			error_messages = @investment.errors.to_a
			flash[:danger] = "Error calculating: #{error_messages}"
			render 'new'
		end
	end

	def destroy
		@investment = Investment.find(params[:id])
		@investment.destroy
		respond_to do |format|
      format.html { redirect_back(fallback_location: root_path) }
      format.js
    end
	end

	private

	def investment_params
		params.require(:investment).permit(:initial_amount, :interest_rate, :interest_rate_period, :period, :period_type, :regular_amount, :regular_period, :compounding_period)
	end
end
