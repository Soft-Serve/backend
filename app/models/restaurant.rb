class Restaurant < ApplicationRecord
  CURRENCIES = {
      cad: 'CAD'
  }.freeze

  DEFAULT_PRIMARY = 'red'.freeze
  DEFAULT_SECONDARY = 400
  DEFAULT_FONT = 'Quicksand'

  # Relations
  has_many :menus
  has_many :dietaries
  has_many :users
  has_one :banner
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
      self.tint = self.tint || DEFAULT_SECONDARY
      self.font = self.font || DEFAULT_FONT
    end
  end
end
