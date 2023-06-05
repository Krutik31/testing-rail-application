FactoryBot.define do
  factory :user do
    email { 'user@gmail.com' }
    username { 'user' }
    password { Faker::Internet.password }
  end

  factory :testuser, class: 'User' do
    username { 'testinguser' }
    email { Faker::Internet.email }
    password { Faker::Internet.password }
  end

  factory :product do
    product_name { 'test product rspec' }
    price { 500 }
    description { 'test description rspec' }
  end
end
