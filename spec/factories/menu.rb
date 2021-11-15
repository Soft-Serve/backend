FactoryBot.define do
  factory :menu, class: Menu do
    name { 'Lunch Menu' }

    association :restaurant, factory: :restaurant
  end
end
