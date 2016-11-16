class Product < ApplicationRecord
  belongs_to :shop
  has_one :photo, as: :imageable, dependent: :destroy

  validates :name, :price, :stock, presence: true
  validates_numericality_of :price, :stock, greater_than_or_equal_to: 0

  accepts_nested_attributes_for :photo, reject_if: proc {|attr| attr["image"].blank?}
end
