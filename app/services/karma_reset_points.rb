# frozen_string_literal: true

class KarmaResetPoints
  def call
    User.find_in_batches do |batch|
      batch.each do |user|
        user.update(karma_points: user.karma)
      end
    end
  end
end
