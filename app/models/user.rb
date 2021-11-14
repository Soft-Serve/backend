class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
  include DeviseTokenAuth::Concerns::User

  belongs_to :restaurant, class_name: 'Restaurant'

  def pending_any_confirmation
    if (!confirmed? || pending_reconfirmation?)
      yield
    else
      false
    end
  end
end
