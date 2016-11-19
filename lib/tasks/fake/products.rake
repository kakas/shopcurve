namespace :fake do

  task :shop => :environment do
    Shop.delete_all
    Shop.create(title: "better Life", email: "shrimptrain@gmail.com")
  end

  task :products => :environment do
    Product.delete_all
    shop = Shop.first

    10.times do |n|
      shop.products.build(
        name: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph,
        price: Faker::Number.number(3),
        stock: Faker::Number.number(1),
      )
    end
    shop.save

  end

end
