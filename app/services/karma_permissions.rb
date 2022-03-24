# frozen_string_literal: true

class KarmaPermissions
  # rubocop:disable Layout/HashAlignment
  PERMISSIONS = {
    read_only:                 1,
    one_per_day:               2,
    one_per_hour:              4,
    one_per_five_min:          8,
    publish_topic:             16,
    remove_ads_and_karma_vote: 32,
    karma_vote_negative:       64,
    publish_self_pr:           128,
    invite:                    256,
  }.freeze

  KARMA_TABLE = {
    ..-31    => PERMISSIONS[:read_only],
    -30..-11 => PERMISSIONS[:one_per_day],
    -10..-6  => PERMISSIONS[:one_per_hour],
    -5..-1   => PERMISSIONS[:one_per_five_min],
    0..0     => PERMISSIONS[:publish_topic],
    1..4     => PERMISSIONS[:remove_ads_and_karma_vote],
    5..29    => PERMISSIONS[:karma_vote_negative],
    30..50   => PERMISSIONS[:publish_self_pr],
    51..     => PERMISSIONS[:invite],
  }.freeze
  # rubocop:enable Layout/HashAlignment

  attr_reader :karma, :mask

  def initialize(karma: nil, mask: nil)
    @karma = karma
    @mask = mask
  end

  def permissions_mask
    KARMA_TABLE.reduce(0) do |mask, (range, perm)|
      mask += perm

      break mask if range.cover?(karma)
    end
  end

  def permissions
    return karma_permissions if karma.present?

    mask_permissions
  end

  private

  def mask_permissions
    PERMISSIONS.invert.each_with_object([]) do |list, (num, perm)|
      list << perm if mask & num
    end
  end

  def karma_permissions
    KARMA_TABLE.each_with_object([]) do |(range, perm), list|
      list << perm

      break list if range.cover?(karma)
    end
  end
end
