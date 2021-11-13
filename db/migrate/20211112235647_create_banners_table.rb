class CreateBannersTable < ActiveRecord::Migration[5.2]
  def change
    create_table :banners_tables do |t|
      t.string :header, null: false
      t.string :photo
      t.string :sub_header
      t.references :restaurant, foreign_key: { on_delete: :cascade }, index: true, null: false
    end
  end
end
