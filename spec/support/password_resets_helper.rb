module PasswordResetsHelper
  def reset_password(user)
		visit sign_in_path
		click_link 'Forgot Password?'
		fill_in 'email', with: user.email
		click_button 'RECOVER'
	end
end
