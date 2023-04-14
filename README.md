# Sleep Tracker App

# Pre-requisites

- Ruby 2.7.6
- Rails 5.2.8.1
- SQLite3

# Installation

## ruby & bundle
    ```
      > ruby -v
      ruby 2.7.6p219

      > bundle install

      > rails s -p 3000 -b 0.0.0.0
    ```

## database
    ```
      # copy database.yml.example as database.yml
      > cp config/database.yml.example config/database.yml

      > rails db:create
      > rails db:migrate
      > rails db:seed
    ```
# Docker
  
  Go to repository directory `cd /goodnight-app`

  Run docker build command to build the image

  ```
    > docker build .
  ```


  Run the command using docker compose to start the application
  
  ```
    > docker compose up
  ```

  Check the container name

  ```
    > docker ps
  ```

  Access the container and setup database(for fresh install only)

  ```
  > exec -it goodnight_app-web-1 bash
  > rails db:create
  > rails db:migrate
  > rails db:seed
  ```

  You can access the application at `http://localhost:3000`

## API

### Endpoints

#### GET /api/v1/users
##### Description
Fetch Users

#### GET /api/v1/users/:id/followed-users/:followed_user_id/sleep_sessions
##### Description
View Followed User's sleep logs
##### Parameters
- id -> User ID
- followed_user_id -> ID of followed User that you want to view sleep logs

#### GET /api/v1/users/:id/followed-users
##### Description
Fetch Followed Users
##### Parameters
- id -> User ID

#### POST /api/v1/users/follow-user
##### Description
Follow a User
##### Parameters
- id -> User ID
- followed_user_id -> ID of the User that you want to follow

#### POST /api/v1/users/log-session
##### Description
Log sleep session
##### Parameters
- id -> User ID

### Responses
  - 200 -> Success Request
  - 400 -> Validation Error e.g User already followed
  - 404 -> User or Followed User not found

## Test

Run command `rails test`
