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
  context 'validations' do
    should validate_presence_of(:name)
    should validate_uniqueness_of(:name)
  end
end
