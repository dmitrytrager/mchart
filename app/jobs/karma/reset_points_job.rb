# frozen_string_literal: true

class Karma::ResetPointsJob < ApplicationJob
  queue_as :karma

  def perform
    KarmaResetPoints.new.call
  end
end
