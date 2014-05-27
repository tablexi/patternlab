namespace :patternlab do
  desc 'Publishes the pattern lab using the local installation of PHP'
  task :publish_local do
    run_locally do
      execute 'bundle exec rake patternlab:generate'

      roles(:web).each do |server|
        execute "rsync -vr --exclude='.DS_Store' public/pattern-lab #{server.user}@#{server}:#{current_path}/public/"
      end
    end
  end

  desc 'Publishes the pattern lab using the remote installation of PHP'
  task :publish do
    on roles(:web) do
      within release_path do
        with rails_env: fetch(:rails_env) do
          rake "patternlab:generate"
        end
      end
    end
  end
end
