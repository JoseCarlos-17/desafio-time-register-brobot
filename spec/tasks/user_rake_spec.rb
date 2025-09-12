require 'rails_helper'
require 'rake'

RSpec.describe "users:populate", type: :task do
  before(:all) { Rails.application.load_tasks }
  let(:task) { Rake::Task['users:populate'] }

  context 'when generate 100 users, each with 20 time registers' do
    before do
      task.invoke
    end

    it 'must return 100 users count' do
      expect(User.count).to eq(100)
    end
  end

  context 'when the task starts again, must to skip the existing users' do

    before do
      task.invoke
      task.reenable
      task.invoke
    end

    it 'the user count must still eq 100' do
      expect(User.count).to eq(100)
    end
  end
end