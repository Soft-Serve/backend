class AddFilterNameToDietaries < ActiveRecord::Migration[6.0]
  def change
    add_column :dietaries, :filter_name, :string, null: false
  end
end
