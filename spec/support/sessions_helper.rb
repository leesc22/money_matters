module SessionHelper
  def sign_in(user)
		visit sign_in_path
		fill_in 'email', with: user.email
		fill_in 'password', with: user.password
		click_button 'SIGN IN'
	end
end
