# frozen_string_literal: true

class KarmaVote < ApplicationRecord
  # belongs_to :voter, class_name: "User"
  belongs_to :votee, class_name: "User", counter_cache: :karma

  validates :vote, presence: true
  validates :vote, inclusion: [-1, 1]
end
