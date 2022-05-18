class Promotion < ApplicationRecord
  # Relations
  has_many :menu_categories
  belongs_to :restaurant

  # Validations
  validates_presence_of :start_time, :end_time, :name, :days
  
  
  def active?
    return false unless self.days.split(',').include?(Date.today.strftime("%A"))
    return false unless self.start_time <= Time.new(2022, 1, 1, Time.zone.now.hour, Time.zone.now.min, Time.zone.now.sec)
    return false unless self.end_time > Time.new(2022, 1, 1, Time.zone.now.hour, Time.zone.now.min, Time.zone.now.sec)

    true
  end
end
