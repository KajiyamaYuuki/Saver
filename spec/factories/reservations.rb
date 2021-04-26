FactoryBot.define do
  factory :reservation do
    start_scheduled_at { "002021-05-01-14:30" }
    end_scheduled_at { "002021-05-01-15:30" }
  end
end
