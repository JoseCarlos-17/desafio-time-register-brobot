class TimeRegister < ApplicationRecord
  belongs_to :user

  validates :clock_in, :user_id, presence: true
  validate :clock_in_must_be_after_clock_out
  validate :only_one_open_register_per_user, on: :create

  private

  def only_one_open_register_per_user
    if self.user && self.user.time_registers.where(clock_out: nil).exists?
      errors.add(:clock_out, "User already has an open time register")
    end
  end

  def clock_in_must_be_after_clock_out
    if self.clock_out && self.clock_out <= self.clock_in
      errors.add(:clock_out, "must to be after clock_in")
    end
  end
end
