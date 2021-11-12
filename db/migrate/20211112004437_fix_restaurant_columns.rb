class FixRestaurantColumns < ActiveRecord::Migration[5.2]
  def change
    rename_column :restaurants, :primary_colour, :colour
    remove_column :restaurants, :secondary_colour
    add_column :restaurants, :tint, :integer
  end
end
