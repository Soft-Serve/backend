class AddPromotionsAndPromotionCategories < ActiveRecord::Migration[6.1]
  def change
    create_table :promotions do |t|
      t.string :name, null: false
      t.string :description
      t.string :days, null: false
      t.timestamp :start_time, null: false
      t.timestamp :end_time, null: false
      t.references :restaurant, foreign_key: { on_delete: :cascade }, index: true, null: false
    end

    create_table :promotion_categories do |t|
      t.integer :discount, null: false
      t.string :unit, null: false, default: 'percentage'
      t.references :promotion, foreign_key: { on_delete: :cascade }, index: true, null: false
      t.references :menu_category, foreign_key: { on_delete: :cascade }, index: true, null: false
    end
  end
end
