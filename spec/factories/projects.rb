FactoryBot.define do
  date = Date.new(2000)

  factory :project do
    user
    name { Faker::Name.name }
    project_type { 'work' }
    start_at { date.beginning_of_year }
    end_at { date.end_of_year }
  end
end