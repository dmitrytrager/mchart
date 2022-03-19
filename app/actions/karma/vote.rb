# frozen_string_literal: true

class Karma::Vote
  attr_reader :voter, :votee, :vote

  def initialize(voter, votee, vote)
    @voter = voter
    @votee = votee
    @vote = vote
  end

  def call
    return if voter.id == votee.id
    return unless [-1, 1].include?(vote)
    return if vote == 1 && votee.max_karma?
    return if voter.karma_points < 2

    karma_vote = votee.karma_votes.find_or_initialize_by(voter_id: voter.id)
    return if karma_vote.persisted? && karma_vote.updated_at > 1.day.ago

    ActiveRecord::Base.transaction do
      voter.update(karma_points: voter.karma_points - 2)
      karma_vote.vote = vote
      karma_vote.save
    end
  end
end
