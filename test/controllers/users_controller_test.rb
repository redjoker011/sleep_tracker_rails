class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    Follow.destroy_all
  end

  test '/users successfully fetch users' do
    get '/api/v1/users'
    assert_response :success
  end

  test '/sleep-sessions successfully fetch followed user sleep sessions' do
    follower = User.first
    followee = User.last
    # Follow User
    follower.follow!(followee)

    get "/api/v1/users/#{follower.id}/followed-users/#{followee.id}/sleep-sessions"
    assert_response :success
  end

  test '/sleep-sessions raise 404 if user not exists' do
    followee = User.last

    get "/api/v1/users/99/followed-users/#{followee.id}/sleep-sessions"
    assert_response(404)
  end

  test '/sleep-sessions raise 404 if followed user not exists' do
    follower = User.first

    get "/api/v1/users/#{follower.id}/followed-users/99/sleep-sessions"
    assert_response(404)
  end

  test '/followed-users successfully fetch followed users' do
    follower = User.first
    followee = User.last
    # Follow User
    follower.follow!(followee)

    get "/api/v1/users/#{follower.id}/followed-users"
    assert_response :success
  end

  test '/follow-user successfully follow a user' do
    follower = User.first
    followee = User.last

    post '/api/v1/users/follow-user', params: { id: follower.id, followed_user_id: followee.id }
    assert_response :success
  end

  test '/follow-user raise 404 error when user does not exists' do
    followee = User.last

    post '/api/v1/users/follow-user', params: { id: 9999, followed_user_id: followee.id }
    assert_response(404)
  end

  test '/follow-user raise 404 error when followed user does not exists' do
    follower = User.first

    post '/api/v1/users/follow-user', params: { id: follower.id, followed_user_id: 999 }
    assert_response(404)
  end

  test '/follow-user raise 400 error when user is already followed' do
    follower = User.first
    followee = User.last
    # Follow User
    follower.follow!(followee)

    post '/api/v1/users/follow-user', params: { id: follower.id, followed_user_id: followee.id }
    assert_response(400)
  end

  test '/log-session successfully log sleep session' do
    user = User.first

    post '/api/v1/users/log-session', params: { id: user.id }
    assert_response :success
  end

  test '/log-session raise 404 when user does not exists' do
    post '/api/v1/users/log-session', params: { id: 999 }
    assert_response(404)
  end
end
