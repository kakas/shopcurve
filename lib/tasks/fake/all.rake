namespace :fake do
  task :all => %w(fake:shop fake:products fake:users fake:orders)
end
