namespace :fake do

  task :orders => :environment  do
    Order.delete_all

    Shop.transaction do
      Shop.all.each do |shop|
        10.times { build_a_order_to_shop(shop) }
        shop.save
      end
    end
  end

  def build_a_order_to_shop(shop)
    cart = Cart.new
    5.times { cart.items << Product.all.sample }

    order = shop.orders.build
    order.build_info(information)
    order.build_item_cache_from(cart)
    order.calculate_total_price!(cart)
    order.set_payment_data!(payment_data)
    order.pay!
  end

  def payment_data
    data = {
      payment_method: "CREDIT"
    }
  end

  def information
    name = Faker::Name.first_name
    info = {
      name:    name,
      phone:   Faker::Number.number(9).to_i,
      address: Faker::Address.street_name,
      email:   Faker::Internet.free_email(name),
    }
  end

end
