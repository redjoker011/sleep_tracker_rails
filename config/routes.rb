Rails.application.routes.draw do
  scope path: 'api/v1/users', module: 'api/v1', as: :v1 do
    get '/', to: 'users#index'
  end

  scope path: 'api/v1/user', module: 'api/v1', as: :v1 do
    post '/log-session', to: 'users#log_session'
  end
end
