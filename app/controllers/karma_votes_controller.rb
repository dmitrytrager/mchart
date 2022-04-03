# frozen_string_literal: true

class KarmaVotesController < ApplicationController
  before_action :authenticate_user!
  before_action :check_permission, only: :update

  def create
    Karma::Vote.new(current_user, votee, karma_vote_params[:vote].to_i).call
  end

  def update
    karma_vote.update(vote: karma_vote.vote * -1)
  end

  private

  def karma_vote
    @karma_vote ||= votee.karma_votes.find_by(voter_id: current_user.id)
  end

  def votee
    User.find(params[:user_id])
  end

  def karma_vote_params
    params.require(:karma_vote).permit(:vote)
  end

  def check_permission
    permissions = KarmaPermissions.new(karma: current_user.reload.karma).permissions
    return if karma_vote.vote == 1 && permissions.include?(KarmaPermissions::PERMISSIONS[:karma_vote_negative])
    return if karma_vote.vote == -1 && permissions.include?(KarmaPermissions::PERMISSIONS[:remove_ads_and_karma_vote])

    head :bad_request
  end
end
