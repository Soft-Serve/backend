class PromotionCategory < ApplicationRecord
  UNITS = {
    percentage: 'percentage',
    amount: 'amount'
  }.freeze

  # Relations
  belongs_to :menu_category
  belongs_to :promotion

  # Validations
  validates_presence_of :unit, :discount, :menu_category_id, :promotion_id
  validates :unit, inclusion: { in: UNITS.values }, allow_nil: false
end
