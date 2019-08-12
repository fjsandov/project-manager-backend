FactoryBot.define do
  factory :user do
    email { Faker::Internet.email }
    password { 'blah123456789' }
  end
end