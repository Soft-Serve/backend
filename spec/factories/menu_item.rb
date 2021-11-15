FactoryBot.define do
  factory :menu_item, class: MenuItem do
    name { 'Sauvignon Blanc' }
    description { 'Kim Crawford, 2017' }

    association :menu_category, factory: :menu_category
  end
end
