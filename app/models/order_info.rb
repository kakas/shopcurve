class OrderInfo < ApplicationRecord
  belongs_to :order, optional: true

  validates :name, :phone, :address, presence: true
end
