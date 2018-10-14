FROM ruby:2.5

RUN apt-get update -qq && apt-get install -y build-essential libpq-dev

# https://github.com/docker-library/ruby/issues/226
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - \
  && apt-get install -y nodejs

ENV RAILS_ROOT /var/www/top_ten
ENV RAILS_ENV='production'
ENV RACK_ENV='production'

RUN mkdir -p $RAILS_ROOT
WORKDIR $RAILS_ROOT

COPY Gemfile Gemfile
COPY Gemfile.lock Gemfile.lock
RUN bundle install --jobs 10 --retry 5 --without development test

COPY . .
RUN bundle exec rake assets:precompile

EXPOSE 3000
CMD ["bundle", "exec", "puma", "-C", "config/puma.rb","-b", "ssl://0.0.0.0:3000?key=/var/www/top_ten/production/secrets/server.key&cert=/var/www/top_ten/production/secrets/server.crt&verify_mode=none"]
