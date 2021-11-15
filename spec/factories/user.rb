FactoryBot.define do
  factory :user do
    first_name { 'Ross' }
    last_name { 'Geller' }
    email { 'ross@geller.com' }
    role { 'admin' }
    password { 'friends' }
  end
end