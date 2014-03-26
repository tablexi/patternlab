namespace :patternlab do
  task :init do
    if File.exist? "#{Rails.root}/pattern-lab"
      puts "Already initialized."
      return
    end
    %x(rsync -rv --exclude=.git #{File.dirname(__FILE__)}/../../patternlab-php/ #{Rails.root}/pattern-lab)
    puts "Copied library into /pattern-lab"
  end

  # TODO make an upgrade task that pulls from git and copy just the core/ directory

  task :generate do
    Dir.chdir("#{Rails.root}/pattern-lab") do
      %x(php core/builder.php -g)
    end
    FileUtils.rm_r "#{Rails.root}/public/pattern-lab" if File.exist?("#{Rails.root}/public/pattern-lab")
    FileUtils.cp_r "#{Rails.root}/pattern-lab/public/", "#{Rails.root}/public/pattern-lab/"
  end
end

