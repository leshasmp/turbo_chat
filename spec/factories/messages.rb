# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    content { Faker::Lorem.sentence }

    user
    room
  end
end
