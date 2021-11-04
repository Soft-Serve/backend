class AddAddressToRestaurant < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :address_line_1, :string
    add_column :restaurants, :address_line_2, :string
    add_column :restaurants, :city, :string
    add_column :restaurants, :province, :string
    add_column :restaurants, :postal_code, :string
    add_column :restaurants, :country, :string
  end
end
