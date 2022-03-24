# frozen_string_literal: true

class Karma::ResetJob < ApplicationJob
  queue_as :karma

  def perform(user_id)
    user = User.find_by(id: user_id)
    return unless user

    KarmaReset.new(user).call
  end
end
