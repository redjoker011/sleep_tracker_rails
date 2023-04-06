# frozen_string_literal: true

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
  TIME_FORMAT = '%Y-%m-%d %I:%M:%S %p'

  validates :created_at, presence: true, uniqueness: { scope: :user_id }

  belongs_to :user

  scope :order_by_sleep, -> { order(sleep_time: :desc) }
  scope :order_by_created_at, -> { order(created_at: :desc) }

  class << self
    # Initialize New Sleep Log Session
    def new_session!
      create!(created_at: DateTime.now)
    end
  end

  # End current open sleep log session
  #
  # @return [Void]
  def end_session!
    wakeup_time = DateTime.now
    sleep_time_hour = ((created_at - wakeup_time) / 1.hour).round
    update(wakeup_at: wakeup_time, sleep_time: sleep_time_hour)
  end

  # Format sleep time
  #
  # @return [String]
  def normalized_sleep_time
    created_at.strftime(TIME_FORMAT)
  end

  # Format wakeup time
  #
  # @return [String]
  def normalized_wakeup_time
    return nil unless wakeup_at

    wakeup_at.strftime(TIME_FORMAT)
  end
end
