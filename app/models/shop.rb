class Shop < ApplicationRecord
  has_many :maintainer, class_name: "User"
  has_many :customers
  has_many :orders
  has_many :products
  has_one  :photo, as: :imageable, dependent: :destroy

  has_many :carts, dependent: :destroy

  validates_presence_of :title
end
