# frozen_string_literal: true

class Comment < ApplicationRecord
  include Valueable

  belongs_to :user
  belongs_to :chart
  has_many :likes, as: :voteable

  validates :text, presence: true

  def age
    case (Time.zone.now - created_at) / 1.minute
    when ..4
      :five
    when 5..59
      :minutes
    when 60..1439
      :hours
    else
      :day
    end
  end
end
