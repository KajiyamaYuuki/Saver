FactoryBot.define do
  factory :staff, class: Staff do
    sequence(:name) { |n| "staff#{n}" }
    sequence(:description) { |n| "staff#{n}の紹介文です" }
    role { "オーナー" }
    sex { "man" }
    work_history { "20" }
  end
end
