FactoryBot.define do
  factory :task do
    project
    title { Faker::Name.name }
    description { Faker::Lorem.paragraph }
    deadline { Date.new(2000).beginning_of_year + 6.months }
    priority { :high }
    status { :pending }
  end
end