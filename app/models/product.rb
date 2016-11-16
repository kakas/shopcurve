class Product < ApplicationRecord
  belongs_to :shop

  validates :name, :price, :stock, presence: true
  validates_numericality_of :price, :stock, greater_than_or_equal_to: 0
end
