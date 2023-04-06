# == Schema Information
#
# Table name: sleep_logs
#
#  id         :integer          not null, primary key
#  sleep_time :float
#  wakeup_at  :datetime
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer
#
# Indexes
#
#  index_sleep_logs_on_created_at_and_user_id  (created_at,user_id) UNIQUE
#  index_sleep_logs_on_user_id                 (user_id)
#
require 'test_helper'

class SleepLogTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:user)
  end

  context 'validations' do
    should validate_presence_of(:created_at)
    should validate_uniqueness_of(:created_at).scoped_to(:user_id)
  end
end
