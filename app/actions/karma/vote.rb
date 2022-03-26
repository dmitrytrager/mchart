# frozen_string_literal: true

class Karma::Vote
  attr_reader :voter, :votee, :vote

  def initialize(voter, votee, vote)
    @voter = voter
    @votee = votee
    @vote = vote
  end

  def call
    return if not_permitted?

    karma_vote = votee.karma_votes.find_or_initialize_by(voter_id: voter.id)
    return if karma_vote.persisted? && karma_vote.updated_at > 1.day.ago

    ActiveRecord::Base.transaction do
      voter.update(karma_points: voter.karma_points - 2)
      karma_vote.vote = vote
      karma_vote.save
    end
  end

  private

  def not_permitted?
    voter_equals_votee? || wrong_vote? || max_karma_reached? || points_not_enough? || !enough_karma?
  end

  def voter_equals_votee?
    voter.id == votee.id
  end

  def wrong_vote?
    [-1, 1].exclude?(vote)
  end

  def max_karma_reached?
    vote == 1 && votee.max_karma?
  end

  def points_not_enough?
    voter.karma_points < 2
  end

  def enough_karma?
    return permissions.include?(KarmaPermissions::PERMISSIONS[:remove_ads_and_karma_vote]) if vote == 1

    permissions.include?(KarmaPermissions::PERMISSIONS[:karma_vote_negative])
  end

  def permissions
    KarmaPermissions.new(karma: voter.karma).permissions
  end
end
