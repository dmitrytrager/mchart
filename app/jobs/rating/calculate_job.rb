# frozen_string_literal: true

class Rating::CalculateJob < ApplicationJob
  queue_as :rating

  BATCH_SIZE = 1_000
  MAX_PENALTY = 1_000
  MAX_SHITFT_HOURS = 24 * 100
  SHIFT_KOEF = -1.3

  def perform
    User.find_in_batches(batch_size: BATCH_SIZE) do |batch|
      batch.each do |user|
        time_shift = time_diff_in_days(Time.zone.now, user.last_value_date)
        new_rating = [(user.median_rating - penalty(time_shift)).round, 0].max
        user.update(rating: new_rating)
      end
    end
  end

  private

  def time_diff_in_days(time1, time2)
    ((time1 - time2) / 1.hour).round
  end

  def penalty(shift)
    return MAX_PENALTY if shift >= MAX_SHITFT_HOURS

    SHIFT_KOEF / Math.log10(shift.to_f / MAX_SHITFT_HOURS)
  end
end
