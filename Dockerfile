FROM ruby:2.7

RUN mkdir /plate_api
WORKDIR /plate_api

RUN gem install -N bundler
COPY . /plate_api
# COPY Gemfile /plate_api/Gemfile
# COPY Gemfile.lock /plate_api/Gemfile.lock
# COPY plate_api.gemspec /plate_api/plate_api.gemspec
RUN bundle install