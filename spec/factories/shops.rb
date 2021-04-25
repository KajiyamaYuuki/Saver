FactoryBot.define do
  factory :shop, class: Shop do
    sequence(:name) { |n| "shop#{n}" }
    post_code { "1008111" }
    prefecture_code { "13" }
    address_city { "千代田区" }
    address_street { "千代田1-1" }
    phone_number { "090-1234-5678" }
    sequence(:email) { |n| "shop#{n}@example.com" }
    url { "shop_url.com" }
  end
end
