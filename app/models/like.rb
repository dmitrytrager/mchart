# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :voter, class_name: "User"
  belongs_to :voteable, polymorphic: true
end
