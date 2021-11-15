FactoryBot.define do
  factory :dietary_instance, class: DietaryInstance do
    association :menu_item, factory: :menu_item
    association :dietary, factory: :dietary
  end
end
