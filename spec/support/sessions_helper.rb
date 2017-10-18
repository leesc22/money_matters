module SessionHelper
  def sign_in(user)
		visit sign_in_path
		fill_in 'session[email]', with: user.email
		fill_in 'session[password]', with: user.password
		click_button 'SIGN IN'
	end
end
