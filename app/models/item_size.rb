class ItemSize < ApplicationRecord
  # Relations
  belongs_to :menu_item

  # Validations
  validates_presence_of :price, :menu_item_id
end
