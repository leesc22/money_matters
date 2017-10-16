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
			UserMailer.account_activation(@user).deliver_now
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
			# session[:user_id] = @user.id
			# flash[:success] = "User created. Please confirm or edit details."
			# redirect_to edit_user_path(@user)
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
