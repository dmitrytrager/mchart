# frozen_string_literal: true

class MedianCalc
  attr_reader :list

  def initialize(list)
    @list = list.sort
  end

  def shifted_midpoint(shift)
    ind = [list.length - 1, (list.length / 2) + shift].min
    list[ind]
  end

  def median
    if list.length.even?
      list[midpoint - 1, 2].sum / 2.0
    else
      list[midpoint]
    end
  end

  private

  def midpoint
    list.length / 2
  end
end
