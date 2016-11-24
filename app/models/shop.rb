class Shop < ApplicationRecord
  has_many :maintainers, class_name: "User"
  has_many :customers
  has_many :orders
  has_many :products
  has_one  :photo, as: :imageable, dependent: :destroy
  has_many :carts, dependent: :destroy

  validates_presence_of :title, :email

  before_create :set_subdomain

  private

  def set_subdomain
    self.subdomain = SecureRandom.uuid.gsub(/\W/, "")
  end

end
