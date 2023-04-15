# == Schema Information
#
# Table name: users
#
#  id         :integer          not null, primary key
#  name       :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
require 'test_helper'

class UserTest < ActiveSupport::TestCase
  context 'associations' do
    should have_many(:sleep_logs)
    should have_many(:followers)
    should have_many(:followings)
  end

  context 'validations' do
    should validate_presence_of(:name)
    should validate_uniqueness_of(:name)
  end

  test 'follow another user' do
    follower = User.first
    followee = User.last
    # Follow User
    follower.follow!(followee)
    
    assert follower.followed?(followee)
  end

  test 'unfollow a followed user' do
    follower = User.first
    followee = User.last
    # Follow User
    follower.follow!(followee)

    # Unfollow User
    follower.unfollow!(followee)
    
    refute follower.followed?(followee)
  end
end
