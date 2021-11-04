class AddMenuCategories < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_categories do |t|
      t.string :name, null: false
      t.string :category_type, null: false
      t.references :menu, foreign_key: { on_delete: :cascade }, index: true, null: false
    end
  end
end
