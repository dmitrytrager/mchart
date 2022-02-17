# frozen_string_literal: true

class Chart < ApplicationRecord
  validates :title, :description, presence: true
  validates :items, presence: true

  belongs_to :user
end
