FROM ruby:2.7

RUN mkdir /plate_api
WORKDIR /plate_api
COPY . /plate_api
RUN bin/setup