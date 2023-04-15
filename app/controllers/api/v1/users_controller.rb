# frozen_string_literal: true

# API Module
module Api
  # V1 API Module
  module V1
    # User API Controller
    class UsersController < ActionController::API
      before_action :initialize_user, except: :index
      before_action :initialize_followed_user, only: %i[follow_user unfollow_user sleep_sessions]

      # Fetch Users
      # GET /api/v1/users
      def index
        users = User.all.map { |user| { id: user.id, name: user.name } }

        render json: users
      end

      # Fetch Followed Users
      # GET /api/v1/users/:id/followed-users
      def followed_users
        render json: @user.followings
      end

      # Log sleep and wake up time
      # POST /api/v1/users/log-session
      def log_session
        # Log Sleep session
        @user.log_sleep!

        sleep_logs = @user
                     .sleep_logs
                     .order_by_created_at
                     .map { |log| format_sleep_log(log) }
        render json: sleep_logs
      end

      # View Followed User's sleep sessions
      # POST /api/v1/users/:id/followed-users/:followed_user_id/sleep-sessions
      def sleep_sessions
        return response_not_found unless @user.followed?(@followed_user)

        sleep_logs = @followed_user
                     .sleep_logs
                     .over_past_week
                     .order_by_sleep
                     .map { |log| format_sleep_log(log) }
        render json: sleep_logs
      end

      # Follow a User
      # POST /api/v1/users/follow-user
      def follow_user
        @user.follow!(@followed_user)

        render json: @user.followings
      rescue ActiveRecord::RecordInvalid
        render json: { error: 'User already being followed'.to_json }, status: 400
      end

      # Unfollow a User
      # DELETE /api/v1/users/unfollow-user
      def unfollow_user
        @user.unfollow!(@followed_user)

        render json: @user.followings
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

      def initialize_user
        @user = User.find_by_id(params[:id])

        return response_not_found unless @user
      end

      def initialize_followed_user
        @followed_user = User.find_by_id(params[:followed_user_id])

        return response_not_found unless @followed_user
      end
    end
  end
end
