# frozen_string_literal: true

FactoryBot.define do
  factory :like do
    association :voter, factory: :user
    voteable { |v| v.association :chart }
  end
end
