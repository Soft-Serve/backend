class Restaurant < ApplicationRecord
  CURRENCIES = {
      cad: 'CAD'
  }.freeze

  DEFAULT_PRIMARY = 'red'.freeze
  DEFAULT_SECONDARY = 400

  # Relations
  has_many :menus
  has_many :dietaries
  has_many :users
  has_many :banners

  # Validations
  validates_presence_of :name
  validates :colour, presence: true
  validates :tint, presence: true
  validates :currency, inclusion: { in: CURRENCIES.values }, allow_nil: false

  after_initialize :defaults

  def defaults
    unless persisted?
      self.currency = CURRENCIES[:cad]
      self.colour = DEFAULT_PRIMARY
      self.tint = DEFAULT_SECONDARY
    end
  end
end
