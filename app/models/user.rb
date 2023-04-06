# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class User < ApplicationRecord
  validates :name, presence: true, uniqueness: true

  has_many :sleep_logs

  # Task
  # Seed Users
  # Allow Users to log sleep time and wake-up time
  # Allow a User to follow/unfollow another User
  #   - Create api for user lists
  # Allow to see sleep record over past week, ordered by length of sleep
end
