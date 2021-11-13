class CreateBannersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :banners do |t|
      t.string :header, null: false
      t.string :photo
      t.string :sub_header
      t.boolean :active, null: false, default: true
      t.references :restaurant, foreign_key: { on_delete: :cascade }, index: true, null: false
    end
  end
end
