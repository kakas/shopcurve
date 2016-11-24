class OrderMailer < ApplicationMailer

  def notify_order_placed(shop, order)
    if order.info.email?
      @shop = shop
      @order = order

      mail from: "#{shop.title} <#{shop.email}>", to: order.info_email, subject: "感謝你購買我們的商品, 您的訂單編號是: #{order.token}"
    end
  end

end
