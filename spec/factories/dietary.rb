FactoryBot.define do
  factory :dietary, class: Dietary do
    name { 'gluten' }
    filter_name { 'gluten free' }

    association :restaurant, factory: :restaurant
  end
end
