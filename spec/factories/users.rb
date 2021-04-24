FactoryBot.define do
  factory :user, class: User do
    sequence(:name) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password" }
    password_confirmation { "password" }
  end

  factory :owner, class: User do
    name { "owner" }
    email { "owner@example.com" }
    password { "password" }
    password_confirmation { "password" }
    is_owner { "true" }
  end

end
