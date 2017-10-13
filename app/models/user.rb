class User < ApplicationRecord
  has_many :authentications, dependent: :destroy
  has_many :investments, dependent: :destroy
  has_many :articles, dependent: :destroy
	validates :name, :email, presence: true
	validates :email, uniqueness: true
	validates :email, format: { with: URI::MailTo::EMAIL_REGEXP, message: "Invalid email format!" }
	has_secure_password
	validates :password, length: { is: 8 }, confirmation: true, allow_nil: true
  enum role: [:client, :moderator, :admin, :superadmin]
  mount_uploader :avatar, AvatarUploader

	def self.create_with_auth_and_hash(authentication, auth_hash)
    user = self.create!(
      name: auth_hash["extra"]["raw_info"]["name"],
      email: auth_hash["extra"]["raw_info"]["email"],
      password: SecureRandom.hex(4)
    )

    user.authentications << authentication
    return user
  end

  # grab fb_token to access Facebook for user data
  def fb_token
    x = self.authentications.find_by(provider: 'facebook')
    return x.token unless x.nil?
  end
end
