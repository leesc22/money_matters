class UsersController < ApplicationController
	def show
		@user = User.find(params[:id])
	end
	
	def new
		@user = User.new
	end

	def edit
		@user = User.find(params[:id])
	end

	def create
		@user = User.new(user_params)

		if @user.save
			flash[:success] = "Signed in!"
			redirect_to user_path(@user)
		else
			error_messages = @user.errors.to_a
			flash[:danger] = "#{'Error'.pluralize(error_messages.size)}: #{error_messages}"
			render 'new'
		end
	end

	def update
		@user = User.find(params[:id])

		if @user.update(user_params)
			flash[:success] = "Updated successfully."
			redirect_to @user
		else
			error_messages = @user.errors.to_a
			flash[:danger] = "#{'Error'.pluralize(error_messages.size)}: #{error_messages}"
			render 'edit'
		end
	end

	private

	def user_params
		params.require(:user).permit(:name, :email, :password, :password_confirmation, :avatar)
	end
end
