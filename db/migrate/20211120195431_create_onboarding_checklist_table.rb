class CreateOnboardingChecklistTable < ActiveRecord::Migration[5.2]
  def change
    create_table :onboarding_checklists do |t|
      t.integer :step
      t.string :status
      t.references :restaurant, foreign_key: { on_delete: :cascade }, index: true, null: false
    end
  end
end
