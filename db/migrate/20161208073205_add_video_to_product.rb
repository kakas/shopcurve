class AddVideoToProduct < ActiveRecord::Migration[5.0]
  def change
    add_column :products, :video, :string
  end
end
