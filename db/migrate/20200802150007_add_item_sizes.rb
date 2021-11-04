class AddItemSizes < ActiveRecord::Migration[5.2]
  def change
    create_table :item_sizes do |t|
      t.float :price, null: false
      t.string :unit, default: '1'
      t.references :menu_item, foreign_key: { on_delete: :cascade }, index: true, null: false
    end
  end
end
