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
class SleepLog < ApplicationRecord
  validates :created_at, presence: true, uniqueness: { scope: :user_id }

  belongs_to :user
end
