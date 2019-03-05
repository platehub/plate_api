![Gem](https://img.shields.io/gem/dt/plate_api.svg)
[![Gem Version](https://badge.fury.io/rb/plate_api.svg)](https://badge.fury.io/rb/plate_api)
[![Build Status](https://travis-ci.com/platehub/plate_api.svg?branch=master)](https://travis-ci.com/platehub/plate_api)
[![Maintainability](https://api.codeclimate.com/v1/badges/1e1dafadc880983ce63a/maintainability)](https://codeclimate.com/github/platehub/plate_api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/1e1dafadc880983ce63a/test_coverage)](https://codeclimate.com/github/platehub/plate_api/test_coverage)
# PlateApi

Welcome to the PlateApi gem. This gem provides a wrapper to communicate with the Plate API, taking care of
authentication.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'plate_api'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install plate_api

## Getting started

To get started with a simple connector:

```
# Initialze a connector
con == PlateApi::Connector.new("{{public_key}}", "{{secret_key}}")

# Find information of a specific site with id == 822
site = con.sites.find(822)

# Find all posts in this site
posts = site.posts

# Find all elements in the first post of this site
first_post = posts.first
elements = first_post.elements

# Update the content field 'body' of the first element
element = elements.first
element.update(body: "<h2>My new text</h2>")
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
