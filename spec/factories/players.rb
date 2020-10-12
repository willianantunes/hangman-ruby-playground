# frozen_string_literal: true

FactoryBot.define do
  factory :player do
    name { Faker::Movies::StarWars.character }
    email { Faker::Internet.email }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    gender { Faker::Gender.short_binary_type }
  end
end
