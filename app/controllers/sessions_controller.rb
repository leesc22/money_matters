class SessionsController < ApplicationController
	def new
	end

	def create
		user = User.find_by_email(params[:email].downcase)
		if user && user.authenticate(params[:password])
			if user.activated?
				session[:user_id] = user.id
				flash[:success] = "Signed in!"
				redirect_to user
			else
				message  = "Account not activated. "
        message += "Check your email for the activation link."
        flash[:warning] = message
        redirect_to sign_in_path
      end
		else
			error_messages = user.errors.to_a
			flash[:danger] = "Error. Invalid authentication!"
			render 'new'
		end
	end

	def destroy
		session[:user_id] = nil
		redirect_to sign_in_path
	end

	def create_from_omniauth
		auth_hash = request.env["omniauth.auth"]
		authentication = Authentication.find_by_provider_and_uid(auth_hash["provider"], auth_hash["uid"]) || Authentication.create_with_omniauth(auth_hash)

		# if: previously already logged in with OAuth
		if authentication.user
			user = authentication.user
			authentication.update_token(auth_hash)
			@next = user_path(user)
			@notice = "Signed in!"
		# else: user logs in with OAuth for the first time
		else
			user = User.create_with_auth_and_hash(authentication, auth_hash)
			#you are expected to have a path that leads to a page for editing user details
			@next = edit_user_path(user)
			@notice = "User created. Please confirm or edit details."
		end

		# sign_in(user)
		session[:user_id] = user.id
		flash[:success] = @notice
		redirect_to @next
	end
end
