![Gem](https://img.shields.io/gem/dt/plate_api.svg)
[![Gem Version](https://badge.fury.io/rb/plate_api.svg)](https://badge.fury.io/rb/plate_api)
[![Build Status](https://travis-ci.com/platehub/plate_api.svg?branch=master)](https://travis-ci.com/platehub/plate_api)
[![Maintainability](https://api.codeclimate.com/v1/badges/1e1dafadc880983ce63a/maintainability)](https://codeclimate.com/github/platehub/plate_api/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/1e1dafadc880983ce63a/test_coverage)](https://codeclimate.com/github/platehub/plate_api/test_coverage)
# PlateApi

Welcome to the PlateApi gem. This gem provides a wrapper to communicate with the [Plate API](https://api-doc.getplate.com), taking care of
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

## Getting started (TLDR;)

To get started with a simple connector:

```
# Initialze a connector
plate_api = PlateApi.new("{{public_key}}", "{{secret_key}}")

# Find information of a specific site with id == 822
site = plate_api.sites.find(822)

# Find all posts in this site
posts = site.posts

# Find all elements in the first post of this site
first_post = posts.first
elements = first_post.elements

# Update the content field 'body' of the first element
element = elements.first
element.update(body: "<h2>My new text</h2>")
```

## Establishing a connection object

To create a connection object, representing a connection to the Plate API,
you need a public and a secret key. The [Plate API docs](https://api-doc.getplate.com) explain how to get such keys.

Given these two keys, a connection object can be established as follows:

```
plate_api = PlateApi.new("{{public_key}}", "{{secret_key}}")
```

The Plate API object can be used to find resources with a certain id:

## Retrieve a resource by id.

To retrieve a resource with a specific id, do the following: (to retrieve an element with `id=12`)

```
element = plate_api.elements.find(12)
```

## Create/Update/Delete resources given an object

To create a resource, you first retrieve the parent of the resource you want to create.
Second, you pass the create parameters in the `create_{{resource}}` method:

```
column = plate_api.columns.find(12)
element = column.create_element(content_type_id: 71, some_content_parameter: "Avé moi")
```

To update a resource:

```
element = plate_api.element.find(36)
element.update(some_content_parameter: "New content")
```

To delete a resource (be careful):

```
element = plate_api.element.find(223)
element.delete
```

## Create/Update/Delete resources directly:

It is also possible to use the `plate_api` instance to execute actions directly,
without first retrieving the object itself.

To create a resource:

```
column = plate_api.columns.find(12)
plate_api.elements.create(column, content_type_id: 71, some_content_parameter: "Avé moi")
```

To update a resource :

```
plate_api.elements.update(36, some_content_parameter: "New content")
```

To delete a resource:

```
plate_api.elements.delete(223)
```

## List child resources

To list all childs of a resource, for example to get all elements in a section:

```
section = plate_api.sections.find(50)
all_elements = section.elements
```

To pass some arguments to the request (like pagination, or to filter on content_type):

```
section = plate_api.sections.find(50)
all_elements = section.elements(content_type_id: 150, page: 12, per_page: 10)
```

To find the total amount of childs of a resource:

```
section = plate_api.sections.find(50)
count = section.elements_total_count
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rspec spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## License

The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
