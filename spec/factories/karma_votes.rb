# frozen_string_literal: true

FactoryBot.define do
  factory :karma_vote do
    association :voter, factory: :user
    association :votee, factory: :user
    vote { 1 }
  end
end
