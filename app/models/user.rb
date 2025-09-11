class User < ApplicationRecord
  has_many :time_registers, dependent: :destroy

  validates :name, :email, presence: true
end
