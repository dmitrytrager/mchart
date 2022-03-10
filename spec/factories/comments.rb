# frozen_string_literal: true

FactoryBot.define do
  factory :comment do
    user
    chart
    text { "Text" }
  end
end
