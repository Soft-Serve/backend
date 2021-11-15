FactoryBot.define do
  factory :menu_category, class: MenuCategory do
    name { 'Wines' }
    category_type { 'beverage' }

    association :menu, factory: :menu
  end
end
