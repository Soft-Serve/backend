class AddAvailableToMenuItems < ActiveRecord::Migration[5.2]
  def change
    add_column :menu_items, :available, :boolean, null: false, default: true
  end
end
