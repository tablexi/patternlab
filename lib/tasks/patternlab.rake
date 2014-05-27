require 'patternlab/renderer/haml'
require 'patternlab/renderer/erb'

namespace :patternlab do
  desc "Initialize patternlab (create a directory of source files in `/pattern-lab`)"
  task :init do
    if File.exist? "#{Rails.root}/pattern-lab"
      puts "Already initialized."
      next
    end

    Rake::Task["patternlab:copy_to_tmp"].invoke
    Rake::Task["patternlab:build"].invoke
    %x(rsync -rv #{Rails.root}/tmp/patternlab-php/source/ #{Rails.root}/pattern-lab)
    puts "Pattern Lab source files have been copied into /pattern-lab"
  end

  # TODO make an upgrade task that pulls from git and copy just the core/ directory
  desc 'Generate the pattern lab (to `/public/pattern-lab/`)'
  task :generate do
    unless File.exist? "#{Rails.root}/pattern-lab"
      puts "Run patternlab:init first"
      next
    end
    Rake::Task["patternlab:copy_to_tmp"].invoke
    Rake::Task["patternlab:copy_source_to_tmp"].invoke
    puts "Building..."
    Rake::Task["patternlab:render_erb"].invoke
    Rake::Task["patternlab:render_haml"].invoke
    Rake::Task["patternlab:build"].invoke
    puts "Build complete. Copying to /public/pattern-lab"
    Rake::Task["patternlab:copy_to_public"].invoke
    puts "Done"
  end

  # Everything below here should not be called manually

  task :render_haml => :environment do
    Patternlab::Renderer::Haml.render_all("#{Rails.root}/tmp/patternlab-php/source")
  end

  task :render_erb => :environment do
    Patternlab::Renderer::Erb.render_all("#{Rails.root}/tmp/patternlab-php/source")
  end

  task :build do
    Dir.chdir("#{Rails.root}/tmp/patternlab-php") do
      %x(php core/builder.php -g)
    end
  end

  task :copy_source_to_tmp do
    FileUtils.rm_r "#{Rails.root}/tmp/patternlab-php/source"
    FileUtils.cp_r "#{Rails.root}/pattern-lab/", "#{Rails.root}/tmp/patternlab-php/source"
  end

  task :copy_to_tmp do
    php_directory = "#{File.dirname(__FILE__)}/../../patternlab-php/"
    if Dir["#{php_directory}*"].empty?
      raise "There was a problem copying the pattern lab files from the gem. If
you are using Bundler's github path, make sure to include
:submodules => true in the gem declaration

gem 'patternlab', github: 'jhanggi/patternlab', submodules: true
"
    end
    %x(rsync -rv --exclude=.git "#{php_directory}" "#{Rails.root}/tmp/patternlab-php")
  end

  task :copy_to_public do
    FileUtils.rm_r "#{Rails.root}/public/pattern-lab" if File.exist?("#{Rails.root}/public/pattern-lab")
    FileUtils.cp_r "#{Rails.root}/tmp/patternlab-php/public/", "#{Rails.root}/public/pattern-lab/"
  end
end

