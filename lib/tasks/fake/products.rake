namespace :fake do

  task :shop => :environment do
    Shop.delete_all
    shop = Shop.create(title: "better Life", email: "shrimptrain@gmail.com")
    shop.update(subdomain: "sub")
  end

  task :products => :environment do
    Product.delete_all
    shop = Shop.first

    10.times do |n|
      shop.products.build(
        name: Faker::Lorem.sentence,
        description: Faker::Lorem.paragraph,
        price: Faker::Number.number(3),
        stock: 10,
        video: "https://www.youtube.com/embed/8cMhQ_teEoY",
      )
    end
    shop.save

  end

end
