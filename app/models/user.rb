# frozen_string_literal: true

class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
    :recoverable, :rememberable, :confirmable,
    :validatable, :lockable, :timeoutable,
    :trackable # , :omniauthable

  has_many :charts
  has_many :comments
  # has_many :votes_for_karma, class_name: "KarmaVote", foreign_key: :voter_id
  has_many :karma_votes, foreign_key: :votee_id

  MAX_KARMA_ZERO_RATING = 4

  def max_karma?
    rating.zero? && karma == MAX_KARMA_ZERO_RATING
  end

  def cumulative_rating
    charts.sum { |chart| chart.likes.size } +
      comments.sum { |comment| comment.likes.size }
  end

  def median_rating
    MedianRating.new(charts, comments).call
  end
end
