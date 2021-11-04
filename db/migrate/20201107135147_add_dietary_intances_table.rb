class AddDietaryIntancesTable < ActiveRecord::Migration[5.2]
  def change
    create_table :dietary_instances do |t|
      t.references :dietary, foreign_key: { on_delete: :cascade }, index: true, null: false
      t.references :menu_item, foreign_key: { on_delete: :cascade }, index: true, null: false
    end
  end
end
