# frozen_string_literal: true

FactoryBot.define do
  factory :chart do
    user
    title { "Title" }
    description { "Description" }
    items { [{ text: "text" }] }
  end
end
