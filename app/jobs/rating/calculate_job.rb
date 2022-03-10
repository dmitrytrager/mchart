# frozen_string_literal: true

class Rating::CalculateJob < ApplicationJob
  queue_as :rating

  def perform
    User.find_in_batches do |user|
      user.update(rating: user.median_rating)
    end
  end
end
