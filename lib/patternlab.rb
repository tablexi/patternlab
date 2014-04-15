require "patternlab/version"

module Patternlab
  require 'patternlab/railtie' if defined?(Rails)
  require 'patternlab/recipe' if defined?(Capistrano)
end
