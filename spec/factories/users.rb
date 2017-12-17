FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@email.com"}
    password "Leena$@1387"
    password_confirmation "Leena$@1387"
  	 factory :test_user do
      email "hamza@gmail.com"
      password "password"
      password_confirmation "password"
    end
  end
end
