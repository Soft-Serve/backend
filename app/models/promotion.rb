class Promotion < ApplicationRecord
  # Relations
  has_many :menu_categories
  belongs_to :restaurant
  has_many :promotion_categories

  # Validations
  validates_presence_of :start_time, :end_time, :name, :days
  
  def active?
    return false unless self.days.split(',').include?(Date.today.strftime("%A"))
    return false unless self.start_time <= now
    return false unless self.end_time > now

    true
  end

  def now 
    @now ||= Time.new(2022, 1, 1, Time.zone.now.hour, Time.zone.now.min, Time.zone.now.sec, '-05:00')
  end
end
