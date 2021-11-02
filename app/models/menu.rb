class Menu < ApplicationRecord
  # Relations
  belongs_to :restaurant
  has_many :menu_categories

  # Validations
  validates_presence_of :name, :restaurant_id
end
