class MenuCategory < ApplicationRecord
  TYPES = {
    food: 'food',
    beverage: 'beverage'
  }.freeze

  # Relations
  belongs_to :menu
  has_many :menu_items

  # Validations
  validates_presence_of :name, :menu_id
  validates :category_type, inclusion: { in: TYPES.values }, allow_nil: false
end
