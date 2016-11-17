namespace :fake do
  task :users => :environment do
    User.delete_all
    User.create(
      email: "shrimptrain@gmail.com",
      password: "asdfasdf",
      password_confirmation: "asdfasdf",
      shop_id: Shop.first.id
    )
  end
end
