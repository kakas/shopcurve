class Shop < ApplicationRecord
  has_many :maintainer, class_name: "User"
  has_many :products
  has_one  :photo, as: :imageable, dependent: :destroy

  validates_presence_of :title
end
