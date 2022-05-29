class AddBackgroundColourToRestaurantsTable < ActiveRecord::Migration[6.1]
  def change
    add_column :restaurants, :background_colour, :string, null: false
    add_column :restaurants, :background_tint, :integer, null: false
  end
end
