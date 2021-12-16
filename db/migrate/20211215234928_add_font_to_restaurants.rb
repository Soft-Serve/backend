class AddFontToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :font, :string, null: false
  end
end
