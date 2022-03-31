# frozen_string_literal: true

class KarmaVotesController < ApplicationController
  before_action :authenticate_user!

  def create
    Karma::Vote.new(current_user, User.find(karma_vote_params[:votee_id]), vote).call
  end

  def update
    karma_vote.update(vote: karma_vote.vote * -1)
  end

  private

  def karma_vote
    current_user.votes_for_karma.find(params[:id])
  end

  def karma_vote_params
    params.require(:karma_vote).permit(:votee_id, :vote)
  end
end
