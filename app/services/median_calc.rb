# frozen_string_literal: true

class MedianCalc
  attr_reader :list

  def initialize(list)
    @list = list.sort
  end

  def midpoint
    list[list.length / 2]
  end

  def shifted_midpoint(shift)
    ind = [list.length - 1, (list.length / 2) + shift].min
    list[ind]
  end

  def median
    midpoint = list.length / 2
    if a.length.even?
      sorted[midpoint - 1, 2].sum / 2.0
    else
      sorted[midpoint]
    end
  end
end
