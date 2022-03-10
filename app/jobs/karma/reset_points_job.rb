# frozen_string_literal: true

class Karma::ResetPointsJob < ApplicationJob
  queue_as :karma

  def perform
    User.find_in_batches do |user|
      user.update(karma_points: user.karma)
    end
  end
end
