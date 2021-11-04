class AddSlugToRestaurant < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :slug, :string, null: false
  end
end
