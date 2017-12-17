FactoryBot.define do
  factory :task do
    name "My task"
    description "My Description"
    privacy "private_access"
    complete false
    factory :public_task do
      privacy "public_access"
    end
  end
end
