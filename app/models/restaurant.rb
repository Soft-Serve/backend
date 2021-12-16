class Restaurant < ApplicationRecord
  CURRENCIES = {
      cad: 'CAD'
  }.freeze

  DEFAULT_PRIMARY = 'red'.freeze
  DEFAULT_SECONDARY = 400
  DEFAULT_FONT = 'Sans'

  # Relations
  has_many :menus
  has_many :dietaries
  has_many :users
  has_many :banners
  has_many :menu_items, through: :menus
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
      self.colour = DEFAULT_PRIMARY
      self.tint = DEFAULT_SECONDARY
      self.font = DEFAULT_FONT
    end
  end
end
