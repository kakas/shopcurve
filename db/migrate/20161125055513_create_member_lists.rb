class CreateMemberLists < ActiveRecord::Migration[5.0]
  def change
    create_table :member_lists do |t|
      t.belongs_to :shop
      t.belongs_to :user

      t.timestamps
    end
  end
end
