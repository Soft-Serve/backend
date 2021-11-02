class Dietary < ApplicationRecord
  # Relations
  belongs_to :restaurant
  has_many :dietary_instances
  # Validations
  validates_presence_of :name, :restaurant_id
end
