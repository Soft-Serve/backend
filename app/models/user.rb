class User < ApplicationRecord
  extend Devise::Models
  # Include default devise modules.
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable
  include DeviseTokenAuth::Concerns::User

  belongs_to :restaurant, class_name: 'Restaurant'


  def confirm(args = {})
    pending_any_confirmation do
      if confirmation_period_expired?
        self.errors.add(:email, :confirmation_period_expired,
          period: Devise::TimeInflector.time_ago_in_words(self.class.confirm_within.ago))
        return false
      end

      self.confirmed_at = Time.now.utc

      saved = if pending_reconfirmation?
        skip_reconfirmation!
        self.email = unconfirmed_email
        self.unconfirmed_email = nil

        # We need to validate in such cases to enforce e-mail uniqueness
        save(validate: true)
      else
        save(validate: args[:ensure_valid] == true)
      end

      after_confirmation if saved
      saved
    end
  end

  def pending_any_confirmation
    if (!confirmed? || pending_reconfirmation?)
      yield
    else
      p "CONFIRMED AT"
      p self.confirmed_at
      # self.errors.add(:email, :already_confirmed)
      false
    end
  end
end
