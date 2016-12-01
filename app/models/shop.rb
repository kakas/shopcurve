class Shop < ApplicationRecord

  has_many :maintainers, class_name: "User"
  has_many :member_lists
  has_many :members, through: :member_lists, source: :user
  has_many :customers
  has_many :orders
  has_many :products
  has_many :carts, dependent: :destroy

  validates_presence_of :title, :email

  before_create :set_subdomain

  def pending_orders_size
    orders.pending.size
  end

  private

  def set_subdomain
    self.subdomain = SecureRandom.uuid.gsub(/\W/, "")
  end

end
