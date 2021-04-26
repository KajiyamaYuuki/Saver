FactoryBot.define do
  factory :menu, class: Menu do
    sequence(:title) { |n| "menu#{n}" }
    price { "10,000" }
    interval_hour { "1" }
    reservationable { "true" }
    sequence(:description) { |n| "menu#{n}の説明文です" }
  end
end
