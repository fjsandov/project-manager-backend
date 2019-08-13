FactoryBot.define do
  factory :project_comment, class: :Comment do
    association :commentable, factory: :project
    body { Faker::Lorem.paragraph }
  end

  factory :task_comment, class: :Comment do
    association :commentable, factory: :task
    body { Faker::Lorem.paragraph }
  end
end