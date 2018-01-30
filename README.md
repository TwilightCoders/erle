[![Version      ](https://img.shields.io/gem/v/erle.svg?maxAge=2592000)](https://rubygems.org/gems/erle)
[![Build Status ](https://travis-ci.org/TwilightCoders/erle.svg)](https://travis-ci.org/TwilightCoders/erle)
[![Code Climate ](https://api.codeclimate.com/v1/badges/762cdcd63990efa768b0/maintainability)](https://codeclimate.com/github/TwilightCoders/erle/maintainability)
[![Test Coverage](https://codeclimate.com/github/TwilightCoders/erle/badges/coverage.svg)](https://codeclimate.com/github/TwilightCoders/erle/coverage)
[![Dependencies ](https://gemnasium.com/badges/github.com/TwilightCoders/erle.svg)](https://gemnasium.com/github.com/TwilightCoders/erle)

# ERLE::Parser

http://erlang.org/doc/reference_manual/data_types.html

Erlang Expressions are a bit different from your typical programming language. ERLE::Parser helps by parsing a string of expressions into a rich (or otherwise) data-structure for Ruby to consume.

## Requirements
Ruby 2.2+

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'erle'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install erle

## Usage

```ruby
ERLE.parse(" {a,[{a_foo,'ABCDE',\"ABCDE\",<<\"ABCDE\">>}]} ")
$ {:a=>[{:a_foo=>["ABCDE", "ABCDE", "ABCDE"]}]}
```

## Development

After checking out the repo, run `bundle` to install dependencies. Then, run `bundle exec rspec` to run the tests.

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/TwilightCoders/erle. This project is intended to be a safe, welcoming space for collaboration, and contributors are expected to adhere to the [Contributor Covenant](http://contributor-covenant.org) code of conduct.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).
