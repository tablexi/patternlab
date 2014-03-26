require 'patternlab'
require 'rails'
module Patternlab
  class Railtie < Rails::Railtie
    rake_tasks do
      load 'tasks/patternlab.rake'
    end
  end
end
