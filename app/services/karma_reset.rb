# frozen_string_literal: true

class KarmaReset
  attr_reader :user

  def initialize(user)
    @user = user
  end

  def call
    return if user.karma_reset_at

    ActiveRecord::Base.transaction do
      user.touch(:karma_reset_at)
      user.karma_votes.destroy_all
    end
  end
end
