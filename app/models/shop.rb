class Shop < ApplicationRecord
  has_many :products
  has_one :photo, as: :imageable, dependent: :destroy
end
