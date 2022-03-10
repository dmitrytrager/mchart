# frozen_string_literal: true

class KarmaPermissions
  PERMISSIONS = {
    1 =>   :read_only,
    2 =>   :one_per_day,
    4 =>   :one_per_hour,
    8 =>   :one_per_five_min,
    16 =>  :publish_topic,
    32 =>  :remove_ads_and_karma_vote,
    64 =>  :karma_vote_negative,
    128 => :publish_self_pr,
    256 => :invite,
  }.freeze

  KARMA_TABLE = {
    ..-31    => PERMISSIONS.invert[:read_only],
    -30..-11 => PERMISSIONS.invert[:one_per_day],
    -10..-6  => PERMISSIONS.invert[:one_per_hour],
    -5..-1   => PERMISSIONS.invert[:one_per_five_min],
    0        => PERMISSIONS.invert[:publish_topic],
    1..4     => PERMISSIONS.invert[:remove_ads_and_karma_vote],
    5..29    => PERMISSIONS.invert[:karma_vote_negative],
    30..50   => PERMISSIONS.invert[:publish_self_pr],
    51..     => PERMISSIONS.invert[:invite],
  }.freeze

  attr_reader :karma, :mask

  def initialize(karma:, mask:)
    @karma = karma
    @mask = mask
  end

  def permissions_mask
    KARMA_TABLE.each_with_object(0) do |mask, (range, perm)|
      next unless range.cover?(karma)

      mask += perm
    end
  end

  def permissions
    PERMISSIONS.each_with_object([]) do |list, (num, perm)|
      list << perm if mask & num
    end
  end
end
