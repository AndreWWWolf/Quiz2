FactoryBot.define do
  factory :idea do
    title { Faker::Book.title  }
    description { Faker::ChuckNorris.fact  }
    association :user, Factory: :user
  end
end
