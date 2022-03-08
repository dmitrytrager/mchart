# frozen_string_literal: true

class Rating::CalculateJob < ApplicationJob
  queue_as :rating

  def perform
    User.find_in_batches do |user|
      user.update(rating: user.cumulative_rating)
    end
  end
end
