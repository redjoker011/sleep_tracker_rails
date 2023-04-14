FROM ruby:2.7.6
RUN apt-get update -qq && apt-get install -y build-essential nodejs git vim && rm -rf /var/lib/apt/lists/*
WORKDIR /goodnight_app

COPY Gemfile /goodnight_app/Gemfile
COPY Gemfile.lock /goodnight_app/Gemfile.lock

RUN bundle install

COPY entrypoint.sh /usr/local/bin
RUN chmod +x /usr/local/bin/entrypoint.sh
ENTRYPOINT ["entrypoint.sh"]
EXPOSE 3000
