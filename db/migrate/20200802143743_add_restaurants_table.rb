class AddRestaurantsTable < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.string :name, null: false
      t.string :logo
      t.string :colour
      t.integer :tint
      t.string :currency, null: false
    end
  end
end
