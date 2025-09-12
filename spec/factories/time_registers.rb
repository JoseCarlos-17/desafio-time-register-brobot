FactoryBot.define do
  factory :time_register do
    clock_in { "2025-09-12 09:00:00" }
    clock_out { "2025-09-12 09:30:00" }
    user { nil }
  end
end
    