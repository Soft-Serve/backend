class AddFilterNameToDietaries < ActiveRecord::Migration[5.2]
  def change
    add_column :dietaries, :filter_name, :string, null: false
  end
end
