# frozen_string_literal: true

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :chart
  has_many :likes, as: :voteable

  validates :text, presence: true
end
