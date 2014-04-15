namespace :patternlab do
  desc 'Publishes the pattern lab'
  task :publish do
    run_locally do
      execute 'bundle exec rake patternlab:generate'

      roles(:web).each do |server|
        execute "rsync -vr --exclude='.DS_Store' public/pattern-lab #{server.user}@#{server}:#{current_path}/public/"
      end
    end
  end
end
