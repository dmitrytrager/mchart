# frozen_string_literal: true

class Karma::Vote
  attr_reader :voter, :votee, :vote

  def initialize(voter, votee, vote)
    @voter = voter
    @votee = votee
    @vote = vote
  end

  def call
    return unless [-1, 1].include?(vote)
    return if vote == 1 && votee.max_karma?

    karma_vote = voter.karma_votes.find_or_initialize_by(votee_id: votee.id)
    karma_vote.vote = vote
    karma_vote.save
  end
end
