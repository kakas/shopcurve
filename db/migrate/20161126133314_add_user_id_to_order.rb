class AddUserIdToOrder < ActiveRecord::Migration[5.0]
  def change
    add_belongs_to :orders, :user
  end
end
