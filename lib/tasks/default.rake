namespace :db do
  task :recreate => %w(db:drop db:create db:migrate db:seed)
end
