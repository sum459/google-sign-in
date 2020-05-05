#google-signin

RUN rails new google-sign-in -d postgresql

RUN bundle

edit database.yml as per local dtabase

RUN rails db:setup

add to gemfile: gem "devise", gem 'omniauth-google-oauth2'

RUN bundle

configure omniauth.rb (config/initializers/omniauth.rb)

RUN rails generate devise:install

edit config/development.rb for host localhost.com

RUN rails generate devise User

RUN rails db:migrate

in user.rb -> devise :database_authenticatable, :registerable, :omniauthable

RUN rails g scaffold Home

edit homes_controller and defined social_login function 

in routes.rb -> root to: 'homes#index'

in routes.rb -> get '/users/auth/:provider/callback' => 'homes#social_login'

in routes.rb -> get '/users/auth/failure' => 'home#social_failure'

