# == Schema Information
#
# Table name: follows
#
#  id          :integer          not null, primary key
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  followee_id :integer
#  follower_id :integer
#
# Indexes
#
#  index_follows_on_followee_id_and_follower_id  (followee_id,follower_id) UNIQUE
#
class Follow < ApplicationRecord
  # Follower -> User who follows
  belongs_to :follower, foreign_key: :follower_id, class_name: 'User'
  # Followee -> User who's being followed
  belongs_to :followed_user, foreign_key: :followee_id, class_name: 'User'

  validates :followee_id, :follower_id, presence: true
  validates :follower_id, uniqueness: { scope: :followee_id }

  validate :follower_and_followee

  private

  def follower_and_followee
    errors.add(:followee_id, 'cant follow yourself') if follower == followed_user
  end
end
