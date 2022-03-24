# frozen_string_literal: true

module Valueable
  extend ActiveSupport::Concern

  module ClassMethods
    def with_count_likes
      joins(:likes)
        .select("#{table_name}.*, COUNT(likes.id) as count")
        .group("#{table_name}.id")
        .order(:count)
    end
  end
end
