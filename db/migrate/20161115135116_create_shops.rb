class CreateShops < ActiveRecord::Migration[5.0]
  def change
    create_table :shops do |t|
      t.string :title, default: ""
      t.string :email, default: ""

      t.timestamps
    end
  end
end
