class Customer < ApplicationRecord
  belongs_to :shop
  has_many :orders

  validates :name, :phone, :address, presence: true
end
