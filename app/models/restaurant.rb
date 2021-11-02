class Restaurant < ApplicationRecord
  CURRENCIES = {
      cad: 'CAD'
  }.freeze

  DEFAULT_PRIMARY = 'red-400'.freeze
  DEFAULT_SECONDARY = '#2D3142'.freeze

  # Relations
  has_many :menus
  has_many :dietaries
  has_many :users

  # Validations
  validates_presence_of :name
  validates :primary_colour, presence: true
  validates :secondary_colour, presence: true
  validates :currency, inclusion: { in: CURRENCIES.values }, allow_nil: false

  after_initialize :defaults

  def defaults
    unless persisted?
      self.currency = CURRENCIES[:cad]
      self.primary_colour = DEFAULT_PRIMARY
      self.secondary_colour = DEFAULT_SECONDARY
    end
  end
end
