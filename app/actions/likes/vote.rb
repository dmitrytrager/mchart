# frozen_string_literal: true

class Likes::Vote
  attr_reader :voter, :voteable

  def initialize(voter, voteable)
    @voter = voter
    @voteable = voteable
  end

  def call
    return if voter.karma_points < 1
    return if voteable.created_at < 30.days.ago

    like = voteable.likes.find_or_initialize_by(voter_id: voter.id)
    return if like.persisted?

    ActiveRecord::Base.transaction do
      voter.update(karma_points: voter.karma_points - 1)
      like.save
    end
  end
end
