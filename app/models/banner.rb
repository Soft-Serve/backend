class Banner < ApplicationRecord
  # Relations
  belongs_to :restaurant

  # Validations
  validates_presence_of :header, :restaurant_id
end
