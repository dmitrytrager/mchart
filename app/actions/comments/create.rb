# frozen_string_literal: true

class Comments::Create
  attr_reader :creator, :chart, :comment

  def initialize(creator, chart, comment)
    @creator = creator
    @chart = chart
    @comment = comment
  end

  def call
    return unless enough_karma?

    creator.comments.create(comment.merge(chart_id: chart.id))
  end

  def enough_karma?
    last_comment = creator.comments.last
    return permissions.include?(KarmaPermissions::PERMISSIONS[:one_per_day]) if last_comment.nil?
    return permissions.include?(KarmaPermissions::PERMISSIONS[:one_per_day]) if last_comment.age == :day
    return permissions.include?(KarmaPermissions::PERMISSIONS[:one_per_hour]) if last_comment.age == :hours
    return permissions.include?(KarmaPermissions::PERMISSIONS[:one_per_five_min]) if last_comment.age == :minutes

    permissions.include?(KarmaPermissions::PERMISSIONS[:publish_topic])
  end

  def permissions
    KarmaPermissions.new(karma: creator.karma).permissions
  end
end
