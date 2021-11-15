FactoryBot.define do
  factory :restaurant, class: Restaurant do
    name { "Ricarda's" }
    colour { 'red' }
    tint { 400 }
    currency { 'CAD' }
    slug { 'ricardas' }
  end
end
