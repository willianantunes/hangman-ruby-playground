FROM ruby:2.7-alpine

RUN bundle config --global frozen 1

WORKDIR /app

COPY Gemfile Gemfile.lock ./
RUN bundle install

COPY lag_ruby_server.rb ./

CMD ["bundle", "exec", "ruby", "lag_ruby_server.rb"]
