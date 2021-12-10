class AddOnboardingDoneToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :onboarding_done, :boolean, default: false
  end
end
