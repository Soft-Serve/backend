class Promotion < ApplicationRecord
  # Relations
  has_many :menu_categories
  belongs_to :restaurant

  # Validations
  validates_presence_of :start_time, :end_time, :name, :days
end
