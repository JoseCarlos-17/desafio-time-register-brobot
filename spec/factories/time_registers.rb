FactoryBot.define do
  factory :time_register do
    clock_in { Time.current }
    clock_out { Time.current + 1.hour }
    user { nil }
  end
end
    