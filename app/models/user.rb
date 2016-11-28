class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :trackable, :validatable,
    :omniauthable, :omniauth_providers => [:facebook]

  belongs_to :shop, optional: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.password = Devise.friendly_token[0,20]
      # user.name = auth.info.name   # assuming the user model has a name
      # user.image = auth.info.image # assuming the user model has an image
    end
  end

  def shipping_info
    info = slice(:name, :phone, :address, :email)
    info.delete_if { |k, v| v.blank? }
    info
  end

  # overwrite devise email_required?
  # shop maintainer and customer registered through different way
  # shop maintainer login via email
  # customer login via facebook uid
  def email_required?
    uid.blank?
  end

end
