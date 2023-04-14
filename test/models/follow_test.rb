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
require 'test_helper'

class FollowTest < ActiveSupport::TestCase
  context 'associations' do
    should belong_to(:follower)
    should belong_to(:followed_user)
  end

  context 'validations' do
    should validate_presence_of(:follower_id)
    should validate_presence_of(:followee_id)
    should validate_uniqueness_of(:follower_id).scoped_to(:followee_id)
  end
end
