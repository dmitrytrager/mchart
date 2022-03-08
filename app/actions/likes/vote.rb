# frozen_string_literal: true

class Likes::Vote
  attr_reader :voter, :voteable

  def initialize(voter, voteable)
    @voter = voter
    @voteable = voteable
  end

  def call
    like = voter.likes.find_or_initialize_by(voteable_id: voteable.id, voteable_type: voteable.class)

    return if like.persists?
    return if voteable.created_at < 30.days.ago

    like.save
  end
end
