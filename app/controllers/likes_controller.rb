# frozen_string_literal: true

class LikesController < ApplicationController
  before_action :authenticate_user!

  def create
    Likes::Vote.new(current_user, Charts.find(params[:chart_id])).call
  end
end
