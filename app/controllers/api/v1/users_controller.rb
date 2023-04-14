# frozen_string_literal: true

# API Module
module Api
  # V1 API Module
  module V1
    # User API Controller
    class UsersController < ActionController::API
      # Fetch Users
      # GET /api/v1/users
      def index
        users = User.all.map { |user| { id: user.id, name: user.name } }

        render json: users
      end

      # Log sleep and wake up time
      # POST /api/v1/:id/log-session
      def log_session
        user = User.find(params[:id])

        return response_not_found unless user

        # Log Sleep session
        user.log_sleep!

        sleep_logs = user
                     .sleep_logs
                     .order_by_created_at
                     .map { |log| format_sleep_log(log) }
        render json: sleep_logs
      end

      # View Followed User's sleep sessions
      # POST /api/v1/:id/sleep-sessions
      def sleep_sessions
        user = User.find(params[:id])

        return response_not_found unless user

        followed_user = User.find(params[:followed_user_id])

        return response_not_found unless followed_user || !user.follow?(followed_user)

        sleep_logs = followed_user
                     .sleep_logs
                     .order_by_sleep
                     .map { |log| format_sleep_log(log) }
        render json: sleep_logs
      end

      private

      # Return 404 status
      def response_not_found
        render json: { error: 'not-found'.to_json }, status: 404
      end

      def format_sleep_log(log)
        {
          id: log.id,
          start_at: log.normalized_sleep_time,
          ended_at: log.normalized_wakeup_time,
          sleep_time_in_hour: log.sleep_time
        }
      end
    end
  end
end
