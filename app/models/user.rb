class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
  include DeviseTokenAuth::Concerns::User

  belongs_to :restaurant, class_name: 'Restaurant'

  after_create :send_confirmation_email

  private

  def send_confirmation_email
    self.send_confirmation_instructions
  end
end
