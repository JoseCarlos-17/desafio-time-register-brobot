require 'rails_helper'

RSpec.describe TimeRegister, type: :model do
  context 'Attributes' do
    it { is_expected.to have_db_column(:clock_in) }
    it { is_expected.to have_db_column(:clock_out) }
  end

  context 'Associations' do
    it { is_expected.to belong_to(:user) }
  end
end