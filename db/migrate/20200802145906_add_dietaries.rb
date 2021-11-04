class AddDietaries < ActiveRecord::Migration[5.2]
  def change
    create_table :dietaries do |t|
      t.string :name, null: false
      t.references :restaurant, foreign_key: { on_delete: :cascade }, index: true, null: false
    end
  end
end
