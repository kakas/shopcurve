namespace :dev do
  desc "Rebuild system"
  task :build => ["tmp:clear", "log:clear", "db:drop", "db:create", "db:migrate"]
  desc "Rebuild system and fake data"
  task :rebuild => ["dev:build", "fake:all"]
end
