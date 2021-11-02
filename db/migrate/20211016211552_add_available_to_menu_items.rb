class AddAvailableToMenuItems < ActiveRecord::Migration[6.0]
  def change
    add_column :menu_items, :available, :boolean, null: false, default: true
  end
end
