class Dietary < ApplicationRecord
  DIETARIES = [
    { name: "Lactose", filter_name: "Lactose free" },
  	{ name: "Soy", filter_name: "Soy free" },
  	{ name: "Gluten", filter_name: "Gluten free" },
  	{ name: "Tree nuts", filter_name: "Tree nuts free" },
  	{ name: "Shellfish", filter_name: "Shellfish free"},
  	{ name: "Sesame", filter_name: "Sesame free" },
  	{ name: "Eggs", filter_name: "Eggs free" },
  	{ name: "Peanuts", filter_name: "Peanut free" },
  	{ name: "Seafood", filter_name: "Seafood free" },
    { name: "Vegan", filter_name: "Vegan" },
  	{ name: "Vegetarian", filter_name: "Vegetarian" }
].freeze

  # Relations
  belongs_to :restaurant
  has_many :dietary_instances
  # Validations
  validates_presence_of :name, :restaurant_id
end
