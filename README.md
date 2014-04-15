# Patternlab

This is a Ruby-based wrapper around [patternlab.io](http://patternlab.io/). It
is meant to make it easier to include the Pattern Lab within your Rails
projects.

Because Pattern Lab is PHP based, you are required to have PHP 5.3+ installed
on your system.

You are also able to use HAML for your patterns. All `.haml` files will be
rendered to Mustache files before the static site generation.

## Installation

Add this line to your application's Gemfile:

    gem 'patternlab', :github => 'jhanggi/patternlab', :submodules => true

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install patternlab

## Usage

### Initialize

    $ rake patternlab:init

This will create a directory of source files in `/pattern-lab`. These are the
files you will edit to customize your design library. These files should
be committed to version control.

### Generate

    $ rake patternlab:generate

This generates the static site and places it into the public folder. The library
will be available at `/pattern-lab`. It is up to you if you want to commit these
files to source control or add them to .gitignore. If you want the library to
be available on your staging/production server, then you should commit them.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
