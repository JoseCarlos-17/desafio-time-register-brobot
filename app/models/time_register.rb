class TimeRegister < ApplicationRecord
  belongs_to :user

  validates :clock_in, :clock_out, :user_id, presence: true
end
