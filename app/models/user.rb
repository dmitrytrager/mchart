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

  def karma
    karma_votes.sum(&:vote)
  end

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

  def last_value_date
    default_date = DateTime.new(0)
    [last_valued_chart&.created_at || default_date, last_valued_comment&.created_at || default_date].max
  end

  def last_valued_chart
    charts.with_count_likes.last
  end

  def last_valued_comment
    comments.with_count_likes.last
  end
end
