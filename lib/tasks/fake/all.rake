namespace :fake do
  task :all => %w(fake:users fake:shop fake:products)
end
