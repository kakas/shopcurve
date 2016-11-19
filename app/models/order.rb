class Order < ApplicationRecord
  has_secure_token
  belongs_to :shop
  belongs_to :customer
  has_many :items, class_name: "OrderItem"
end
