class OrderInfo < ApplicationRecord
  belongs_to :order, optional: true

  validates :name, :phone, :address, presence: true

  def shipping_info
    info = slice(:name, :phone, :address, :email)
    info.delete_if { |k, v| v.blank? }
    info
  end

end
