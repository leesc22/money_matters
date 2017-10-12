class User < ApplicationRecord
	validates :name, :email, presence: true
	validates :email, uniqueness: true
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Invalid email format!" }
	has_secure_password
	validates :password, length: { is: 8 }
	validates :password, confirmation: true
end
