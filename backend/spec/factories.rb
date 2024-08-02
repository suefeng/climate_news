FactoryBot.define do
  factory :news do
    title { Faker::Book.title }
    summary { Faker::Movie.quote }
    url { Faker::Internet.url }
    images { [Faker::Internet.url, Faker::Internet.url] }
    published_at { "2022-10-05 16:30:00" }
    site_name { Faker::Book.author }
    category { Faker::Book.genre }
  end

  factory :news_message do
    is_bot { false }
    message_body { {"query":"What's the latest climate news for August 02, 2024"} }
  end
end
