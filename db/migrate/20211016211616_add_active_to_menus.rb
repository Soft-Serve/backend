class AddActiveToMenus < ActiveRecord::Migration[5.2]
  def change
    add_column :menus, :active, :boolean, null: false, default: true
  end
end
