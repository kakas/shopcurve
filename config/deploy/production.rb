set :stage, :production
set :branch, :master

role :app, %w(deploy@188.166.186.89)
role :web, %w(deploy@188.166.186.89)
role :db, %w(deploy@188.166.186.89)

set :rails_env, "production"
set :puma_env, "production"
set :puma_config_file, "#{shared_path}/config/puma.rb"
set :puma_conf, "#{shared_path}/config/puma.rb"
