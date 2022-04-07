# frozen_string_literal: true

class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :fetch_comment, only: %i[edit update destroy]

  def create
    Comments::Create.new(current_user, Chart.find(params[:chart_id]), comment_params).call
  end

  def edit; end

  def update
    @comment.update(comment_params)
  end

  def destroy
    @comment.destroy
  end

  private

  def fetch_comment
    @comment ||= current_user.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:chart_id, :text)
  end
end
