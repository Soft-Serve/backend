class AddSlugToRestaurant < ActiveRecord::Migration[6.0]
  def change
    add_column :restaurants, :slug, :string, null: false
  end
end
