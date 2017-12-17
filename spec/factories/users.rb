FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "email#{n}@email.com"}
    password "Leena$@1387"
    password_confirmation "Leena$@1387"
  end
end
