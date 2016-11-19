class Customer < ApplicationRecord
  belongs_to :shop
  has_many :order
end
