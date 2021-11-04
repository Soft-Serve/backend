class AddMenuItems < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_items do |t|
      t.string :name, null: false
      t.string :photo
      t.text :description
      t.references :menu_category, foreign_key: { on_delete: :cascade }, index: true, null: false
    end  
  end
end
