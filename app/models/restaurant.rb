class Restaurant < ApplicationRecord
  CURRENCIES = {
      cad: 'CAD'
  }.freeze

  DEFAULT_PRIMARY = 'red'.freeze
  DEFAULT_TINT = 400
  DEFAULT_BACKGROUND_COLOUR = 'gray'.freeze
  DEFAULT_BACKGROUND_TINT = 100
  DEFAULT_FONT = 'Quicksand'

  # Relations
  has_many :menus
  has_many :dietaries
  has_many :users
  has_many :banners
  has_many :menu_items, through: :menus
  has_many :promotions
  # Validations
  validates_presence_of :name
  validates :colour, presence: true
  validates :tint, presence: true
  validates :font, presence: true
  validates :currency, inclusion: { in: CURRENCIES.values }, allow_nil: false

  after_initialize :defaults

  def defaults
    unless persisted?
      self.currency = CURRENCIES[:cad]
      self.colour = self.colour || DEFAULT_PRIMARY
      self.tint = self.tint || DEFAULT_TINT
      self.font = self.font || DEFAULT_FONT
      self.background_colour = self.background_colour || DEFAULT_BACKGROUND_COLOUR
      self.background_tint = self.background_tint || DEFAULT_BACKGROUND_TINT
    end
  end
end
