# GS Ruby

Simple wrapper for the [Ghostscript](https://www.ghostscript.com/) command – it's assumed that you have the `gs` command installed.

**Note:** This was developed against version _9.20_ of the Ghostscript command and is a work-in-progress. No doubt there are some issues (perhaps even major ones – namespacing, for instance?).

For more detailed documentation, take a look at the source docs – http://www.rubydoc.info/github/lshepstone/gs-ruby

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'gs-ruby'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install gs-ruby

## Usage

Typical usage might look like:

```ruby
GS.run('input.ps', GS::OUTPUT_FILE => 'output.pdf')
```

Or using a block to work with the command before it's run:

```ruby
GS.run('input.ps') do |command|
  command.option(GS::OUTPUT_FILE, 'output.pdf')
end
```

#### Configuration

Global configuration is possible:

```ruby
GS.configure do |config|
  # ...
end
```

#### Logging

By default all output is logged to `$stdout`, but the logger can be configured:

```ruby
# For a single command instance.
GS.run('input.ps') do |command|
  # command.logger =
end

# For all command instances.
GS.configure do |config|
  # config.logger =
end
```

## Development

After checking out the repo, run `bin/setup` to install dependencies. Then, run `rake spec` to run the tests. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/lshepstone/gs-ruby.

## License

The gem is available as open source under the terms of the [MIT License](http://opensource.org/licenses/MIT).

Copyright (c) 2017 Lawrance Shepstone
