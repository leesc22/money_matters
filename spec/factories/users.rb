FactoryBot.define do
  factory :user do
    name "David Lim"
    email "david_lim@na.com"
    password "12345678"
    password_confirmation "12345678"
  end

  factory :user2, class:User do
  	name "David Tan"
    email "david_tan@na.com"
    password "12345678"
    password_confirmation "12345678"
  end
end
