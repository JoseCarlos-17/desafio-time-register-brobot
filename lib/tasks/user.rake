require 'faker'

namespace :users do
  desc 'task for to create users with time registers'
  task populate: :environment do
    users_skipped = 0
    users_created = 0
    time_registers_skipped = 0
    time_registers_created = 0

    puts "creating users and your time registers..."
    100.times do |i|
      name = Faker::Name.name
      email = "user#{i + 1}@example.com"
      user = User.find_by(email: email)

      if user
        users_skipped += 1
        next
      else 
        users_created += 1
        user = User.create!(name: name, email: email)
      end

      10.times do
        date = Faker::Date.between(from: 3.months.ago, to: Date.today)

        start_work = DateTime.parse("#{date} #{rand(8..9)}:#{rand(0..59)}")
        break_for_lunch = DateTime.parse("#{date} #{rand(12..12)}:#{rand(0..59)}")
        back_from_lunch = DateTime.parse("#{date} #{rand(13..14)}:#{rand(0..59)}")
        leaving_work = DateTime.parse("#{date} #{rand(17..18)}:#{rand(0..59)}")
        
        if user.time_registers.exists?(clock_in: start_work..leaving_work)
          time_registers_skipped += 1
          next
        else
          time_registers_created += 1
          TimeRegister.create!(
            clock_in: start_work,
            clock_out: break_for_lunch,
            user_id: user.id
          )
        
          time_registers_created += 1
          TimeRegister.create!(
            clock_in: back_from_lunch,
            clock_out: leaving_work,
            user_id: user.id
          )
        end
      end
    end

    puts "
          users created: #{users_created}\n
          users skipped: #{users_skipped}\n
          time registers created: #{time_registers_created}\n
          time registers skipped: #{time_registers_skipped}\n
        "
    puts "users have been created with your times registers"
  end
end