FROM ruby:2.5
RUN apt-get update -qq && apt-get install -y vim build-essential libpq-dev

# https://github.com/docker-library/ruby/issues/226
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install -y nodejs

RUN mkdir /app
WORKDIR /app
COPY Gemfile /app/Gemfile
COPY Gemfile.lock /app/Gemfile.lock
RUN bundle install
COPY . /app
