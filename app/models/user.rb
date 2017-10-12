class User < ApplicationRecord
	validates :name, :email, :password, :password_confirmation, presence: true
	validates :email, uniqueness: true
	validates :password, length: { is: 8 }
	validates :password, confirmation: true
	has_secure_password
end
