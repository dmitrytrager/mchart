# frozen_string_literal: true

class Chart < ApplicationRecord
  DEFAULT_ITEM_COUNT = 3

  belongs_to :user
  has_many :likes, as: :voteable

  validates :title, :description, presence: true
  validates :items, presence: true
end
