FactoryBot.define do
  factory :item_size, class: ItemSize do
    price { 11 }
    unit { '9 oz' }

    association :menu_item, factory: :menu_item
  end
end
