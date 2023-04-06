# frozen_string_literal: true

# API Module
module Api
  # V1 API Module
  module V1
    # User API Controller
    class UsersController < ActionController::API
      # /api/v1/users
      def index
        users = User.all.map { |user| { id: user.id, name: user.name } }

        render json: users
      end
    end
  end
end
