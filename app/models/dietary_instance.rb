class DietaryInstance < ApplicationRecord
  # Relations
  belongs_to :menu_item
  belongs_to :dietary

  validates_presence_of :menu_item_id, :dietary_id
end

