# frozen_string_literal: true

class Chart < ApplicationRecord
  validates :title, :description, presence: true
  validates :items, presence: true

  DEFAULT_ITEM_COUNT = 3

  belongs_to :user
end
