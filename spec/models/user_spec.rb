require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Attributes' do
    it { is_expected.to have_db_column(:name) }
    it { is_expected.to have_db_column(:email) }
  end

  context 'Associations' do
    it { is_expected.to have_many(:time_registers) }
  end
end