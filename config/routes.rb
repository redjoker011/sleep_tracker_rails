Rails.application.routes.draw do
  scope path: 'api/v1/users', module: 'api/v1', as: :v1 do
    get '/', to: 'users#index'
    get '/:id/followed/:followed_user_id/sleep-sessions', to: 'users#sleep_sessions'

    post '/log-session', to: 'users#log_session'
  end
end
