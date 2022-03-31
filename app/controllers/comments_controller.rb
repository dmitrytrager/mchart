# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_comment, only: %i[create update delete]

  def create
    current_user.comments.create(comment_params)
  end

  def edit; end

  def update
    comment.update(comment_params)
  end

  def delete
    comment.destroy
  end

  private

  def fetch_comment
    @comment ||= current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:chart_id, :text)
  end
end
