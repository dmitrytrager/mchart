# frozen_string_literal: true

class MedianRating
  attr_reader :charts, :comments

  def initialize(charts, comments)
    @charts = charts.map { |chart| chart.likes.size }
    @comments = comments.map { |comment| comment.likes.size }
  end

  def call
    chart_median = MedianCalc.new(charts)
    comments_median = MedianCalc.new(comments)

    chart_median.shifted_midpoint(comments_median.median / comments.size)
  end
end
