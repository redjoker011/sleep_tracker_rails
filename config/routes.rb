Rails.application.routes.draw do
  scope path: 'api/v1/users', module: 'api/v1', as: :v1 do
    get '/', to: 'users#index'
    get '/:id/followed-users/:followed_user_id/sleep-sessions', to: 'users#sleep_sessions'
    get '/:id/followed-users', to: 'users#followed_users'

    post '/follow-user', to: 'users#follow_user'
    delete '/unfollow-user', to: 'users#unfollow_user'
    post '/log-session', to: 'users#log_session'
  end
end
