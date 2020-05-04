# Rockstart::Prefab
A collection of generators for creating pre-built components.

## Usage
Each Prefabricated component is added to a Rails app by running the relevant generator.

Run a default build of rockstart before running these generators, as it assumes rockstart has or has not installed various features.

> bunlde exec rails generate rockstart

### Sitemap (+ robots.txt)

Generates a dynamic sitemap.xml and robots.txt

> bundle exec rails generate rockstart:perfab:sitemap

## Installation
Add this line to your application's Gemfile:

```ruby
gem 'rockstart-prefab'
```

And then execute:
```bash
$ bundle
```

Or install it yourself as:
```bash
$ gem install rockstart-prefab
```

## Contributing
Contribution directions go here.

## License
The gem is available as open source under the terms of the [MIT License](https://opensource.org/licenses/MIT).
